//
//  DetailViewModelTest.swift
//  SimpleImageListCombineTests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import XCTest
import Combine
@testable import SimpleImageListCombine

@MainActor
final class DetailViewModelTest: XCTestCase {
    let timeout: TimeInterval = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil ? 10 : 5
    private var viewModel: DetailViewModel?
    private var cancelables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = DetailViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancelables.removeAll()
        try super.tearDownWithError()
    }

    func testDetailImageSuccess() async throws {
        let expectation = XCTestExpectation(description: "Load detail")
        await viewModel?.loadDetail(imageId: "1")

        viewModel?.$detailModel
            .dropFirst()
            .sink { model in
                XCTAssertEqual(model?.id, "1", "detail id is 1")
                XCTAssertNotEqual(model?.id, "0", "detail id is 1")

                expectation.fulfill()
            }.store(in: &cancelables)

        await fulfillment(of: [expectation], timeout: timeout)
    }
}
