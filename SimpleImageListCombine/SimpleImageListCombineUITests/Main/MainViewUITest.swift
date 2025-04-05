//
//  MainViewUITest.swift
//  SimpleImageListCombineUITests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import XCTest

@testable import SimpleImageListCombine

class MainViewUITest: XCTestCase {

    let timeout: TimeInterval = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil ? 10 : 5
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testMainHeaderViewInitialLoad() throws {
        let headerView = app.otherElements["MainHeaderView"]
        XCTAssertTrue(headerView.waitForExistence(timeout: timeout), "mainHeaderView is exist")
        XCTAssertTrue(headerView.staticTexts["Pic List"].waitForExistence(timeout: timeout), "header text is Pic List")
    }

    func testMainViewInitialLoad() throws {
        // 리스트가 로드되었는지 확인
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: timeout))

        // 초기 로딩 후 이미지 셀이 표시되는지 확인
        let firstCell = list.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: timeout))
    }

    func testInfiniteScroll() throws {
        let list = app.collectionViews.firstMatch

        // 초기 셀 개수 확인
        let initialCellCount = list.cells.count

        // 리스트를 아래로 스크롤
        list.swipeUp(velocity: .fast)
        list.swipeUp(velocity: .fast)

        // 스크롤 후 셀 개수가 증가했는지 확인
        XCTAssertGreaterThan(list.cells.count, initialCellCount)
    }

    func testEmptyState() throws {
        // 빈 상태를 시뮬레이션하기 위해 네트워크 연결을 차단하거나
        // 뷰 모델을 모킹하여 빈 리스트를 반환하도록 설정해야 합니다.
        // 이 부분은 앱의 구조에 따라 구현 방식이 달라질 수 있습니다.

        // 빈 상태 메시지가 표시되는지 확인
        XCTAssertTrue(app.staticTexts["No images available"].exists)
    }
}
