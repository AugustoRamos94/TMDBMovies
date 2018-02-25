//
//  TMDB_MoviesNavigationTests.swift
//  TMDB MoviesUITests
//
//  Created by Augusto Ramos on 24/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest

class TMDB_MoviesNavigationTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListToDetailAndDetailToList() {
        
        let app = XCUIApplication()
        let navUpcoming = app.navigationBars["Upcoming"]
        let navDetail = app.navigationBars["Detail"]
        
        if app.collectionViews.cells.count > 0 {
            app.collectionViews.cells.firstMatch.tap()
            XCTAssert(navDetail.exists, "The Detail view navigation bar does not exist")
            navDetail.buttons["Upcoming"].tap()
            XCTAssert(navUpcoming.exists, "The upcoming view navigation bar does not exist")
        }
    }
    
    func testRefreshControl() {
        
        let app = XCUIApplication()
        let collection = app.collectionViews
        let firstcell = collection.cells.firstMatch
        let start = firstcell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstcell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
