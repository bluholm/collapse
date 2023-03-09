//
//  SettingsSchemeTests.swift
//  collapseTests
//
//  Created by Marc-Antoine BAR on 2023-03-08.
//

import XCTest
@testable import collapse

final class SettingsSchemeTests: XCTestCase {

    func testReturnNameSchemeLangageFileFr() {
        // Given
        UserDefaults.standard.set(["fr"], forKey: "AppleLanguages")
        // When
        let resultFrench = SettingScheme.returnNameSchemeLangageFile()
        // Then
        XCTAssertEqual(resultFrench, "french")
        
    }
    
    func testReturnNameSchemeLangageFileEn() {
        // Given
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        // When
        let resultEnglish = SettingScheme.returnNameSchemeLangageFile()
        // Then
        XCTAssertEqual(resultEnglish, "english")
        
    }
    func testReturnNameSchemeLangageFileSp() {
        // Given
        UserDefaults.standard.set(["es"], forKey: "AppleLanguages")
        // When
        let resultUnknown = SettingScheme.returnNameSchemeLangageFile()
        // Then
        XCTAssertEqual(resultUnknown, "english")
    }
    
    func testLangageFr() {
        // Given
        UserDefaults.standard.set(["fr"], forKey: "AppleLanguages")
        // When
        let resultFrench = SettingScheme.langage()
        // Then
        XCTAssertEqual(resultFrench, "fr")
    }
    
    func testLangageEn() {
        // Given
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        // When
        let resultEnglish = SettingScheme.langage()
        // Then
        XCTAssertEqual(resultEnglish, "en")
    }
    
    func testLangageEs() {
        // Given
        UserDefaults.standard.set(["es"], forKey: "AppleLanguages")
        // When
        let resultUnknown = SettingScheme.langage()
        // Then
        XCTAssertEqual(resultUnknown, "en")
    }
    
}
