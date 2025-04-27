//
//  MockPicSumImageService.swift
//  SimpleImageListCombineTests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Combine
@testable import SimpleImageListCombine

class MockPicSumImageService: PicSumImageServiceProtocol {
    func getImages(page: Int, limit: Int) -> AnyPublisher<[PicSumListDto], APIError> {
        let dto = PicSumListDto(
            id: "1",
            author: "Test Author",
            width: 100,
            height: 100,
            url: "https://test.com",
            downloadUrl: "https://test.com/download"
        )
        return Just([dto])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func detailImage(imageId: String) -> AnyPublisher<PicSumDetailDto, APIError> {
        let dto = PicSumDetailDto(
            id: imageId,
            author: "Test Author",
            width: 100,
            height: 100,
            url: "https://test.com",
            downloadUrl: "https://test.com/download"
        )
        return Just(dto)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
} 