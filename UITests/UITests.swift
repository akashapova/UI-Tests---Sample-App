//
//  UITests.swift
//  UITests
//
//  Created by Альбина Кашапова on 1/30/21.
//

import XCTest

class UITests: XCTestCase, TestCasesClima {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        //reset Authorization status for location
        app.resetAuthorizationStatus(for: .location)
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testTypingCity_UpdatesWeatherLabel_PermissionGranted_GoButton() {
        
        //given User is granting permission
        addUIInterruptionMonitor(withDescription: "Handle location request") { (alert) -> Bool in
            let allowWhileUsingButton = alert.buttons["Allow While Using App"].firstMatch
            if alert.elementType == .alert && allowWhileUsingButton.exists {
                allowWhileUsingButton.tap()
                return true
            } else {
                return false
            }
        }
        //act: type text & tap Go button
        typeText(cityName: "London")
        tapGo()
        
        //assert
        XCTAssertTrue(app.windows.staticTexts["London"].waitForExistence(timeout: 2))
    }
    
    func testTypingCity_UpdatesWeatherLabel_PermissionGranted_SearchButton() {
        
        //arrange: given User is granting permission
        addUIInterruptionMonitor(withDescription: "Handle location request") { (alert) -> Bool in
            let allowWhileUsingButton = alert.buttons["Allow While Using App"].firstMatch
            if alert.elementType == .alert && allowWhileUsingButton.exists {
                allowWhileUsingButton.tap()
                return true
            } else {
                return false
            }
        }
        //act: type text & tap Search button
        typeText(cityName: "London")
        tapSearchButton()
        
        //assert
        XCTAssertTrue(app.windows.staticTexts["London"].waitForExistence(timeout: 2))
    }
    
    func testTapping_CurrentLocationButton_PermissionGranted() {
        
        //given User's current location is SF & User is granting permission
        addUIInterruptionMonitor(withDescription: "Handle location request") { (alert) -> Bool in
            let allowWhileUsingButton = alert.buttons["Allow While Using App"].firstMatch
            if alert.elementType == .alert && allowWhileUsingButton.exists {
                allowWhileUsingButton.tap()
                return true
            } else {
                return false
            }
        }
        app.tap()
        
        //act: tap Current Location button. Simulated Location San Francisco from Location file
        tapLocationButton()
        
        //assert: validating data presented to User
        XCTAssertTrue(app.windows.staticTexts["San Francisco"].waitForExistence(timeout: 2))
    }
    
    func testTapping_CurrentLocationButton_PermisionDenied() {
        
        //given location request denied
        addUIInterruptionMonitor(withDescription: "Handle location request") { (alert) -> Bool in
            return false
        }
        //given that User is presented with initial city, default city is London
        let parseCityName = app.staticTexts["CityName"].label
        
        //act: tap Current Location button
        tapLocationButton()
        
        XCTAssertEqual(parseCityName, "London", "Unexpected cityName")
    }
    
    func testKeyboardIsPresented_WhenTypingCity() {
        
        HomeScreen.textField.element.tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard is not presented")
    }
    
    
    func test_temperatureIsValid() {
        
        typeText(cityName: "Paris")
        let temperatureNumber = Int(app.staticTexts["TemperatureNumber"].label) ?? 0
        XCTAssertTrue(isTemperatureValid(temperatureNumber))
    }
    
    func testTappingSearchButton_WithoutCityName_UpdatesPlaceholder() {
        
        typeText(cityName: "")
        tapSearchButton()
        
        XCTAssertTrue(app.textFields["Type something here"].waitForExistence(timeout: 5))
        
        let placeholderValue = HomeScreen.textField.element.placeholderValue
        XCTAssertEqual(placeholderValue, "Type something here")
    }
}
