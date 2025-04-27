//
//  DetailViewModelTest.swift
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
final class DetailViewModelTest: QuickSpec {

    override class func spec() {
        var viewModel: DetailViewModel?
        var cancelables: Set<AnyCancellable> = []
        var mockService: MockPicSumImageService?

        beforeEach {
            mockService = MockPicSumImageService()
            viewModel = DetailViewModel(service: mockService!)
        }

        afterEach {
            viewModel = nil
            mockService = nil
            cancelables.removeAll()
        }

        context("Load detail") {
            describe("load detail 후 체크") {
                it("1이어야함") {
                    Task {
                        await viewModel?.loadDetail(imageId: "1")

                        viewModel?.$detailModel
                            .dropFirst()
                            .sink { model in
                                expect(model?.id).to(equal("1"), description: "detail id is 1")
                                expect(model?.id).notTo(equal("0"), description: "detail id is 1")
                            }.store(in: &cancelables)
                    }
                }
            }
        }
    }
}
