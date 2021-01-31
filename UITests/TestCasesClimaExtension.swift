//
//  TestCasesClimaExtension.swift
//  UITests
//
//  Created by Альбина Кашапова on 1/30/21.
//

import Foundation
import XCTest

extension TestCasesClima {

    func typeText(cityName: String) {
    HomeScreen.textField.element.tap()
    HomeScreen.textField.element.typeText(cityName)
    }
    
    func tapGo() {
    HomeScreen.goButton.element.tap()
    }
    
    func tapSearchButton() {
        HomeScreen.searchButton.element.tap()
    }
    
    func tapLocationButton() {
        HomeScreen.locationButton.element.tap()
    }
    
    func isTemperatureValid(_ temperatureNumber: Int) -> Bool {
        if temperatureNumber > -90 && temperatureNumber < 70 {
            return true
        } else {
                return false
            }
        }
}
