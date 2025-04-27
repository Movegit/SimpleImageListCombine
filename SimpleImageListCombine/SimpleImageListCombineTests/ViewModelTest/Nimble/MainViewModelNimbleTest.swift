//
//  MainViewModelNimbleTest.swift
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
final class MainViewModelNimbleTest: QuickSpec {
    override class func spec() {
        var viewModel: MainViewModel?
        var cancelables: Set<AnyCancellable> = []
        var mockService: MockPicSumImageService?

        beforeEach {
            mockService = MockPicSumImageService()
            viewModel = MainViewModel(service: mockService!)
            cancelables = []
        }

        afterEach {
            viewModel = nil
            mockService = nil
            cancelables.removeAll()
        }

        describe("MainViewModel 데이터 로딩") {
            context("초기화 후 첫 로드 시") {
                it("에러 상태가 nil이어야 함") {
                    waitUntil(timeout: .seconds(5)) { done in
                        viewModel?.$error
                            .dropFirst()
                            .sink { error in
                                expect(error).to(beNil(), description: "에러 상태가 nil이 아님")
                                done()
                            }
                            .store(in: &cancelables)
                        Task {
                            await viewModel?.loadData(initialize: true)
                        }
                    }
                }
            }

            context("연속 로드 시") {
                it("페이지네이션이 정상 작동해야 함") {
                    waitUntil(timeout: .seconds(5)) { done in
                        Task {
                            // 첫 페이지 로드
                            await viewModel?.loadData(initialize: true)

                            // 두 번째 페이지 추가 로드
                            await viewModel?.loadData(initialize: false)

                            viewModel?.$picList
                                .collect(2) // 두 번의 업데이트 캡처
                                .sink { updates in
                                    let initialCount = updates.first?.count ?? 0
                                    let finalCount = updates.last?.count ?? 0
                                    expect(finalCount).to(beGreaterThan(initialCount), description: "페이지 추가 로드 실패")
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
