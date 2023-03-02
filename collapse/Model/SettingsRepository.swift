//
//  SettingsRepository.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation

final class SettingsRepository {
    
    static private let userDefault = UserDefaults.standard
    
    private enum Keys {
        
        static let userIsPremium = "userIsPremium"
        static let checkItem = "checkItem"
        static let mode = "mode"
        static let didReadPresentation = "didReadPresentation"
        
    }
    
    static var mode: String {
        get {
            return userDefault.string(forKey: Keys.mode) ?? ""
        }
        set {
            userDefault.set(newValue, forKey: Keys.mode)
        }
    }
    
    static var userIsPremium: Bool {
        get {
            return userDefault.bool(forKey: Keys.userIsPremium)
        }
        set {
            userDefault.set(newValue, forKey: Keys.userIsPremium)
        }
    }
    
    static var didReadPresentation: Bool {
        get {
            return userDefault.bool(forKey: Keys.didReadPresentation)
        }
        set {
            userDefault.set(newValue, forKey: Keys.didReadPresentation)
        }
    }
    
    static var checkItem: [String: Bool] {
        get {
            return userDefault.object(forKey: Keys.checkItem) as? [String: Bool] ?? [:]
        }
        set {
            userDefault.set(newValue, forKey: Keys.checkItem)
        }
    }
   
}
