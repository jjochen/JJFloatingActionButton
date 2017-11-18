//
//  JJFloatingActionButton_UITests.swift
//  JJFloatingActionButton_UITests
//
//  Created by Jochen on 16.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import XCTest

class JJFloatingActionButton_UITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testUI() {

        let app = XCUIApplication()
        let firstTabBarButton = app.tabBars.buttons["First"]
        let secondTabBarButton = app.tabBars.buttons["Second"]
        let actionButton = app.otherElements["FloatingActionButton"]
        let item1 = app.otherElements["Item1"]
        let item2 = app.otherElements["Item2"]
        let item3 = app.otherElements["Item3"]

        secondTabBarButton.tap()
        firstTabBarButton.tap()

        XCTAssert(actionButton.exists)
        XCTAssert(!item1.exists)

        actionButton.tap(withNumberOfTaps: 1, numberOfTouches: 1)
        XCTAssert(item1.exists)

        actionButton.tap()
        XCTAssert(!item1.exists)

        actionButton.tap()
        XCTAssert(item1.exists)

        app.children(matching: .window).element(boundBy: 0).tap()
        XCTAssert(!item1.exists)

        actionButton.tap()
        XCTAssert(item1.exists)
        item1.tap(withNumberOfTaps: 1, numberOfTouches: 1)
        app.alerts["item 1"].buttons["OK"].tap()
        XCTAssert(!item1.exists)

        actionButton.tap()
        XCTAssert(item2.exists)
        item2.tap()
        app.alerts["item 2"].buttons["OK"].tap()
        XCTAssert(!item2.exists)

        actionButton.tap()
        XCTAssert(item3.exists)
        item3.tap()
        app.alerts["item 3"].buttons["OK"].tap()
        XCTAssert(!item3.exists)
    }
}
