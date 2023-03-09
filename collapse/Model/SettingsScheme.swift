//
//  SettingsScheme.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

/// Model check langage Scheme Directly on UserDefault Apple Languages.
final class SettingScheme {
    
    /// This method returns a string that represents the language of the user's device. If the language is French, it returns "french", otherwise it returns "english".
    /// - Returns: `french` or `english` String word
    static func returnNameSchemeLangageFile() -> String {
        guard let langage = UserDefaults.standard.stringArray(forKey: "AppleLanguages"),
              langage.indices.contains(0) else { return "english" }
        
        if langage[0].contains("fr") {
           return "french"
        }
        return "english"
    }
    
    /// This method returns a string that represents the language code of the user's device. If the language is French, it returns "fr", otherwise it returns "en".
    /// - Returns: `fr`or `en`
    static func langage() -> String {
        guard let langage = UserDefaults.standard.stringArray(forKey: "AppleLanguages"),
              langage.indices.contains(0) else { return "english" }
        
        if langage[0].contains("fr") {
           return "fr"
        }
        return "en"
    }
}
