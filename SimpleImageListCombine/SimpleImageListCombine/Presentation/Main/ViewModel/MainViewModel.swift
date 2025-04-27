//
//  MainViewModel.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Combine

protocol MainViewListType: ObservableObject {
    func loadData(initialize: Bool) async
    func triggerLoadMore()
    var picList: [PicSumItem] { get }
    var isLoadingData: Bool { get }
    var hasNext: Bool { get }
}

class MainViewModel: MainViewListType {

    @Published private(set) var picList: [PicSumItem] = []
    @Published private(set) var isLoadingData: Bool = false
    @Published private(set) var hasNext: Bool = true
    @Published private(set) var error: APIError?
    @Published private(set) var showErrorAlert: Bool = false

    private let service: PicSumImageServiceProtocol
    private var currentPage: Int = 1
    private var pageSize: Int = 30
    private let loadMoreSubject = PassthroughSubject<Void, Never>()
    private var cancelables = Set<AnyCancellable>()

    init(service: PicSumImageServiceProtocol, pageSize: Int = 30) {
        self.service = service
        self.pageSize = pageSize
        self.setupLoadMoreListener()
    }

    deinit {
        cancelAllSubscriptions()
    }

    @MainActor
    func loadData(initialize: Bool) async {
        if initialize {
            hasNext = true
            currentPage = 1
            picList = []
        }

        if isLoadingData || hasNext == false {
            return
        }

        isLoadingData = true
        error = nil
        showErrorAlert = false

        service.getImages(page: currentPage, limit: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoadingData = false
                
                if case .failure(let error) = completion {
                    self.error = error
                    self.showErrorAlert = true
                }
            } receiveValue: { [weak self] result in
                guard let self else { return }
                let newList = result.map { dto in
                    PicSumItem(
                        id: dto.id ?? "",
                        author: dto.author ?? "",
                        width: dto.width ?? 0,
                        height: dto.height ?? 0,
                        url: dto.url ?? "",
                        downloadUrl: dto.downloadUrl ?? ""
                    )
                }

                self.picList.append(contentsOf: newList)
                self.hasNext = !newList.isEmpty
                if self.hasNext {
                    self.currentPage += 1
                }
            }.store(in: &cancelables)
    }

    private func setupLoadMoreListener() {
        loadMoreSubject
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] in
                guard let self else { return }
                if self.hasNext && !self.isLoadingData {
                    Task {
                        await self.loadData(initialize: false)
                    }
                }
            }
            .store(in: &cancelables)
    }

    func triggerLoadMore() {
        loadMoreSubject.send(())
    }

    func retryLoading() {
        Task {
            await loadData(initialize: false)
        }
    }

    private func cancelAllSubscriptions() {
        cancelables.removeAll()
    }
}
