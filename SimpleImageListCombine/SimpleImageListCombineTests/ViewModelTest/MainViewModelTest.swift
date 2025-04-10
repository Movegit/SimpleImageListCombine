//
//  MainViewModelTest.swift
//  SimpleImageListCombineTests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Combine
import Quick
import Nimble
@testable import SimpleImageListCombine

@MainActor
final class MainViewModelTest: QuickSpec {

    override class func spec() {
        var viewModel: MainViewModel?
        var cancelables: Set<AnyCancellable> = []

        beforeEach {
            viewModel = MainViewModel()
        }

        afterEach {
            viewModel = nil
            cancelables.removeAll()
        }

        context("Load get List") {
            describe("load data 후 체크") {
                it("picList가 비어있으면 안됌") {
                    Task {
                        await viewModel?.loadData(initialize: true)

                        viewModel?.$picList
                            .dropFirst()
                            .sink { list in
                                expect(list.isEmpty).toNot(beFalse(), description: "picList가 비어있음")
                            }.store(in: &cancelables)
                    }
                }
            }
        }
    }
}
