//
//  SettingsRepository.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation

/// The SettingsRepository class is a Swift class that serves as a repository for storing and retrieving user settings data in an iOS app.
///
/// It provides a set of static properties that enable the app to access and manipulate the user settings data that has been stored in the UserDefaults object.
/// The SettingsRepository class is a final class, which means that it cannot be subclassed.
/// It has a private static property called userDefault, which is an instance of the UserDefaults class that is used to store and retrieve user settings data.

final class SettingsRepository {
    
    static private let userDefault = UserDefaults.standard
    
    enum Keys {
        
        static let userIsPremium = "userIsPremium"
        static let checkItem = "checkItem"
        static let mode = "mode"
        static let didReadPresentation = "didReadPresentation"
        static let launchedBefore = "launchedBefore"
        
    }
    
    /// A boolean value that indicates whether the app has been launched before.
    static var launchedBefore: Bool {
        get {
            return userDefault.bool(forKey: Keys.launchedBefore)
        }
        set {
            userDefault.set(newValue, forKey: Keys.launchedBefore)
        }
    }
    /// A string value that specifies the mode of the app.
    static var mode: String {
        get {
            return userDefault.string(forKey: Keys.mode) ?? ""
        }
        set {
            userDefault.set(newValue, forKey: Keys.mode)
        }
    }
    /// A boolean value that indicates whether the user is a premium user.
    static var userIsPremium: Bool {
        get {
            return userDefault.bool(forKey: Keys.userIsPremium)
        }
        set {
            userDefault.set(newValue, forKey: Keys.userIsPremium)
        }
    }
    /// A boolean value that indicates whether the user has read the app presentation.
    static var didReadPresentation: Bool {
        get {
            return userDefault.bool(forKey: Keys.didReadPresentation)
        }
        set {
            userDefault.set(newValue, forKey: Keys.didReadPresentation)
        }
    }
    /// A dictionary that stores a boolean value for each item that the user has checked.
    static var checkItem: [String: Bool] {
        get {
            return userDefault.object(forKey: Keys.checkItem) as? [String: Bool] ?? [:]
        }
        set {
            userDefault.set(newValue, forKey: Keys.checkItem)
        }
    }
   
}
