//
//  MainViewModelTest.swift
//  SimpleImageListCombineTests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import XCTest
import Combine
@testable import SimpleImageListCombine

@MainActor
final class MainViewModelTest: XCTestCase {
    private let timeout: TimeInterval = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil ? 10 : 5
    private var viewModel: MainViewModel?
    private var cancelables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MainViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancelables.removeAll()
        try super.tearDownWithError()
    }

    func testDetailImageSuccess() async throws {
        let expectation = XCTestExpectation(description: "Load get List")

        await viewModel?.loadData(initialize: true)

        viewModel?.$picList
            .dropFirst()
            .sink { list in
                XCTAssertNotEqual(list.isEmpty, true, "picList가 비어있음")

                expectation.fulfill()
            }.store(in: &cancelables)

        await fulfillment(of: [expectation], timeout: timeout)
    }
}
