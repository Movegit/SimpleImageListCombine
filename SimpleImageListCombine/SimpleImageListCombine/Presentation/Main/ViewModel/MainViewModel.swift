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
    var picList: [PicSumItem] { get }
    var isLoadingData: Bool { get }
    var hasNext: Bool { get }
}

class MainViewModel: MainViewListType {

    @Published var picList: [PicSumItem] = []
    @Published var isLoadingData: Bool = false
    @Published var hasNext: Bool = true
    @Published var error: APIError?

    private let service: PicSumImageServiceProtocol
    private var currentPage: Int = 1
    private var pageSize: Int = 30
    private var cancelables = Set<AnyCancellable>()

    init(service: PicSumImageServiceProtocol = PicSumImageService(), defaultPageSize: Int = 30) {
        self.service = service
        self.pageSize = defaultPageSize
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

        error = nil

        service.getImages(page: currentPage, limit: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
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
}
