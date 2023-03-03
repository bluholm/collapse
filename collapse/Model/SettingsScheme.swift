//
//  SettingsScheme.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

final class SettingScheme {
    
    static func returnNameSchemeLangageFile() -> String {
        guard let langage = UserDefaults.standard.stringArray(forKey: "AppleLanguages"),
              langage.indices.contains(0) else { return "english" }
        
        if langage[0].contains("fr") {
           return "french"
        }
        return "english"
    }
    
    static func langage() -> String {
        guard let langage = UserDefaults.standard.stringArray(forKey: "AppleLanguages"),
              langage.indices.contains(0) else { return "english" }
        
        if langage[0].contains("fr") {
           return "fr"
        }
        return "en"
    }
}
