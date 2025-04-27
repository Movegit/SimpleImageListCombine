//
//  DetailViewModel.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Combine

protocol DetailViewListType: ObservableObject {
    func loadDetail(imageId: String) async
    var detailModel: PicSumItem? { get }
}

class DetailViewModel: DetailViewListType {
    private let service: PicSumImageServiceProtocol
    @Published private(set) var detailModel: PicSumItem?
    @Published private(set) var error: APIError?
    @Published private(set) var showErrorAlert: Bool = false

    private var cancelables = Set<AnyCancellable>()

    init(service: PicSumImageServiceProtocol) {
        self.service = service
    }

    deinit {
        cancelAllSubscriptions()
    }

    @MainActor
    func loadDetail(imageId: String) async {
        error = nil
        showErrorAlert = false

        service.detailImage(imageId: imageId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    self.error = error
                    self.showErrorAlert = true
                }
            } receiveValue: { [weak self] image in
                guard let self else { return }
                self.detailModel = PicSumItem(
                    id: image.id ?? "",
                    author: image.author ?? "",
                    width: image.width ?? 0,
                    height: image.height ?? 0,
                    url: image.url ?? "",
                    downloadUrl: image.downloadUrl ?? ""
                )
            }.store(in: &cancelables)
    }

    func getContentData() -> String {
        guard let model = detailModel else { return "No data available" }
        return """
            id: \(model.id)
            author: \(model.author)
            width: \(model.width)
            height: \(model.height)
            url: \(model.url)
            downloadUrl: \(model.downloadUrl)
            """
    }

    private func cancelAllSubscriptions() {
        cancelables.removeAll()
    }
}

struct PicSumItem: Equatable {
    var id: String = ""
    var author: String = ""
    var width: Int = 0
    var height: Int = 0
    var url: String = ""
    var downloadUrl: String = ""
}
