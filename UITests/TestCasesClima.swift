//
//  TestCases.swift
//  UITests
//
//  Created by Альбина Кашапова on 1/30/21.
//

import Foundation

protocol TestCasesClima {
    
    func testTypingCity_UpdatesWeatherLabel_PermissionGranted_GoButton()
    func testTypingCity_UpdatesWeatherLabel_PermissionGranted_SearchButton()
    func testTapping_CurrentLocationButton_PermissionGranted()
    func testTapping_CurrentLocationButton_PermisionDenied()
    func testKeyboardIsPresented_WhenTypingCity()
    func test_temperatureIsValid()
    func testTappingSearchButton_WithoutCityName_UpdatesPlaceholder()
}
