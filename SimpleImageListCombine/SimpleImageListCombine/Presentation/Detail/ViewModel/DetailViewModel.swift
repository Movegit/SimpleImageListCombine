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
    @Published var detailModel: PicSumItem?
    @Published var error: APIError?

    private var cancelables = Set<AnyCancellable>()

    init(service: PicSumImageServiceProtocol = PicSumImageService()) {
        self.service = service
    }

    @MainActor
    func loadDetail(imageId: String) async {
        error = nil

        service.detailImage(imageId: imageId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
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
}

struct PicSumItem: Equatable {
    var id: String = ""
    var author: String = ""
    var width: Int = 0
    var height: Int = 0
    var url: String = ""
    var downloadUrl: String = ""
}
