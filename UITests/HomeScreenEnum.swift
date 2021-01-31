//
//  HomeScreenEnum.swift
//  UITests
//
//  Created by Альбина Кашапова on 1/30/21.
//

import Foundation
import XCTest

enum HomeScreen: String {
    case textField = "Search"
    case searchButton = "SearchButton"
    case goButton = "go"
    case locationButton = "LocationButton"
    
    var element: XCUIElement {
        switch self {
        case .textField:
            return XCUIApplication().textFields["Search"]
        case .searchButton:
            return XCUIApplication().buttons[self.rawValue]
        case .goButton:
            return XCUIApplication().keyboards.buttons[self.rawValue]
        case .locationButton:
            return XCUIApplication().buttons[self.rawValue].firstMatch
        }
    }
}
