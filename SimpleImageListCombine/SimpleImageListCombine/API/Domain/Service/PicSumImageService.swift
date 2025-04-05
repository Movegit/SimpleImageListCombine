//
//  PicSumImageService.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI
import Combine

protocol PicSumImageServiceProtocol {
    func getImages(page: Int, limit: Int) -> AnyPublisher<[PicSumListDto], APIError>
    func detailImage(imageId: String) -> AnyPublisher<PicSumDetailDto, APIError>
}

class PicSumImageService: PicSumImageServiceProtocol {
    private let imageListUrl = "https://picsum.photos/v2/list"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    private func detailImageUrl(imageId: String) -> String {
        return "https://picsum.photos/id/\(imageId)/info"
    }
}

extension PicSumImageService {
    func getImages(page: Int, limit: Int) -> AnyPublisher<[PicSumListDto], APIError> {
        let queryParameters = [
            "page": page,
            "limit": limit
        ]

        return APIHelperCombine.get(
            url: imageListUrl,
            queryParameters: queryParameters,
            headers: nil
        )
    }

    func detailImage(imageId: String) -> AnyPublisher<PicSumDetailDto, APIError> {
        return APIHelperCombine.get(
            url: detailImageUrl(imageId: imageId),
            queryParameters: nil,
            headers: nil
        )
    }
}
