//
//  DetailViewModelNimbleTest.swift
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
final class DetailViewModelSpec: QuickSpec {

    override class func spec() {
        var viewModel: DetailViewModel?
        var cancelables: Set<AnyCancellable> = []

        // 시뮬레이터 여부 확인
        let timeout: Int = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil ? 10 : 5

        beforeEach {
            viewModel = DetailViewModel()
            cancelables = []
        }

        afterEach {
            viewModel = nil
            cancelables.removeAll()
        }

        describe("loadDetail 호출 시") {
            context("유효한 imageId('1')로 요청한 경우") {
                it("detailModel의 id가 '1'이어야 하고 '0'이 아니어야 함") {
                    waitUntil(timeout: .seconds(timeout)) { done in
                        Task {
                            await viewModel?.loadDetail(imageId: "1")

                            viewModel?.$detailModel
                                .dropFirst()
                                .sink { model in
                                    expect(model?.id).to(equal("1"))
                                    expect(model?.id).toNot(equal("0"))
                                    done()
                                }
                                .store(in: &cancelables)
                        }
                    }
                }
            }
        }
    }
}
