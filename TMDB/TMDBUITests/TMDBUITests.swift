//
//  TMDBUITests.swift
//  TMDBUITests
//
//  Created by jc.kim on 3/13/23.
//

import XCTest

class TMDBUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func test_스토어탭에서_인기데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        let collection = app.collectionViews[AccessibilityIdentifiers.Store.collectionView]
        let cell = collection.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Store.featureCell)_0")

        XCTAssertEqual(cell.staticTexts[AccessibilityIdentifiers.Store.featureTitle].label, "The Godfather")
    }
    
    func test_스토어탭에서_최고평점데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        let collection = app.collectionViews[AccessibilityIdentifiers.Store.collectionView]
        let cell = collection.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Store.threeTableCell)_0")

        XCTAssertEqual(cell.staticTexts[AccessibilityIdentifiers.Store.threeTableTitle].label, "똑똑똑")
    }

    func test_스토어탭에서_개봉예정데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        let collection = app.collectionViews[AccessibilityIdentifiers.Store.collectionView]
        let cell = collection.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Store.squareCell)_0")
        
        collection.swipeUp()

        XCTAssertEqual(cell.staticTexts[AccessibilityIdentifiers.Store.squareTitle].label, "Knock at the Cabin")
    }

    func test_스토어탭에서_장르데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        let collection = app.collectionViews[AccessibilityIdentifiers.Store.collectionView]
        let cell = collection.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Store.smallTableCell)_0")
        
        collection.swipeUp()

        XCTAssertEqual(cell.staticTexts[AccessibilityIdentifiers.Store.smallTableTitle].label, "Action  🤣")
    }

    
    func test_검색탭에서_임시데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        app.tabBars.buttons[AccessibilityIdentifiers.Search.tabBarItem].tap()
        
        let table = app.tables[AccessibilityIdentifiers.Search.tableView]
        let cell = table.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Search.searchCell)_0")
        
        XCTAssertEqual(cell.staticTexts[AccessibilityIdentifiers.Search.title].label, "Ironman")
    }
    
    func test_검색탭에서_첫번째셀을선택했을때_디테일뷰로_잘이동되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        app.tabBars.buttons[AccessibilityIdentifiers.Search.tabBarItem].tap()
        
        let table = app.tables[AccessibilityIdentifiers.Search.tableView]
        let cell = table.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifiers.Search.searchCell)_0")
        cell.tap()
        
        XCTAssertEqual(
            app.staticTexts.element(
                matching: .any,
                identifier: AccessibilityIdentifiers.Detail.name).label, "Joker"
        )
    }
    
    func test_트렌드탭에서_임시데이터가_잘로드되는지() throws {
        //given
        //UITESTING flag를 통해 주입
        
        //when
        app.launch()
        
        //then
        app.tabBars.buttons[AccessibilityIdentifiers.Trend.tabBarItem].tap()
        
        XCTAssertEqual(
            app.staticTexts.element(
                matching: .any,
                identifier: AccessibilityIdentifiers.Trend.name).label, "A Man Called Otto"
        )
    }

}
