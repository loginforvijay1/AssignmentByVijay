//
//  MovieListViewControllerUITests.swift
//  LloydsCodingAssignmentUITests
//
//  Created by Vemireddy Vijayasimha Reddy on 08/01/24.
//

import XCTest

final class MovieListViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        var cellsQuery = app.collectionViews.cells
        let aquamanAndTheLostKingdomElement = cellsQuery.otherElements.containing(.staticText, identifier:"Aquaman and the Lost Kingdom").element
        aquamanAndTheLostKingdomElement.swipeUp()
        
        let nowPlayingNavigationBar = app.navigationBars["Now Playing"]
        XCTAssertTrue(nowPlayingNavigationBar.exists)
        let nowPlayingStaticText = nowPlayingNavigationBar.staticTexts["Now Playing"]
        XCTAssertTrue(nowPlayingStaticText.exists)
        
        nowPlayingNavigationBar.buttons["Refresh"].tap()
        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        cellsQuery.otherElements.containing(.staticText, identifier:"A Creature Was Stirring").element.swipeUp()
        
        let verticalScrollBar3PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar3PagesCollectionView.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"Society of the Snow").element.swipeDown()
        verticalScrollBar3PagesCollectionView.swipeDown()
        verticalScrollBar3PagesCollectionView.swipeUp()
        cellsQuery = XCUIApplication().collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Society of the Snow").element.tap()
                
        let refreshButton = app.navigationBars["Now Playing"].buttons["Refresh"]
        XCTAssertNotNil(refreshButton.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
