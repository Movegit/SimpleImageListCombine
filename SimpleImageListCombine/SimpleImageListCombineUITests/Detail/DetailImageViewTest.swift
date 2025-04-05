//
//  DetailImageViewTest.swift
//  SimpleImageListCombineUITests
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import XCTest

@testable import SimpleImageListCombine

class DetailImageViewUITest: XCTestCase {

    let timeout: TimeInterval = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil ? 10 : 5
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testDetailHeaderViewExists() throws {
        let list = app.collectionViews.firstMatch
        let firstCell = list.cells.element(boundBy: 0)

        // 첫 번째 셀이 로드될 때까지 대기
        XCTAssertTrue(firstCell.waitForExistence(timeout: timeout))

        // 첫 번째 셀을 탭
        firstCell.tap()

        sleep(1)
        let headerView = app.otherElements["detailHeaderView"]
        XCTAssertTrue(headerView.waitForExistence(timeout: timeout), "Detail header view should exist")
    }

    func testDetailHeaderViewTextExists() throws {
        let list = app.collectionViews.firstMatch
        let firstCell = list.cells.element(boundBy: 0)

        // 첫 번째 셀이 로드될 때까지 대기
        XCTAssertTrue(firstCell.waitForExistence(timeout: timeout))

        // 첫 번째 셀을 탭
        firstCell.tap()

        sleep(1)
        let titleText = app.staticTexts["detailHeaderTitleText"]
        XCTAssertTrue(titleText.waitForExistence(timeout: timeout), "Detail header text view should exist")
    }

    func testDetailHeaderViewBackButtonExists() throws {
        let list = app.collectionViews.firstMatch
        let firstCell = list.cells.element(boundBy: 0)

        // 첫 번째 셀이 로드될 때까지 대기
        XCTAssertTrue(firstCell.waitForExistence(timeout: timeout))

        // 첫 번째 셀을 탭
        firstCell.tap()

        sleep(1)
        let backButton = app.buttons["detailHeaderBackButton"]
        XCTAssertTrue(backButton.waitForExistence(timeout: timeout), "Detail header backButton view should exist")
    }

    func testImageDisplayed() throws {
        // 이미지가 표시되는지 확인
        // 실제 이미지 요소의 접근성 식별자에 따라 조정이 필요할 수 있습니다
        let image = app.images.firstMatch
        XCTAssertTrue(image.waitForExistence(timeout: timeout), "Image should be displayed")
    }
}
