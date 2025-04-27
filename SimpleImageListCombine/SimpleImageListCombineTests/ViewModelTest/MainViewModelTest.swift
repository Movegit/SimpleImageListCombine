//
//  MainViewModelTest.swift
//  SimpleImageListCombineTests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import SimpleImageListCombine

@MainActor
final class MainViewModelTest: QuickSpec {

    override class func spec() {
        var viewModel: MainViewModel?
        var cancelables: Set<AnyCancellable> = []
        var mockService: MockPicSumImageService?

        beforeEach {
            mockService = MockPicSumImageService()
            viewModel = MainViewModel(service: mockService!)
        }

        afterEach {
            viewModel = nil
            mockService = nil
            cancelables.removeAll()
        }

        context("Load images") {
            describe("load data 후 체크") {
                it("1이어야함") {
                    Task {
                        await viewModel?.loadData(initialize: true)

                        viewModel?.$picList
                            .dropFirst()
                            .sink { list in
                                expect(list.first?.id).to(equal("1"), description: "first image id is 1")
                                expect(list.first?.id).notTo(equal("0"), description: "first image id is 1")
                            }.store(in: &cancelables)
                    }
                }
            }
        }
    }
}
