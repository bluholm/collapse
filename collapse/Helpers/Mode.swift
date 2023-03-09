//
//  Mode.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

/// An enumeration that represents the different modes available for the app.
enum Mode {
    
    /// Represents the essential mode.
    case essential
    
    /// Represents the intermediate mode.
    case intermediate
    
    /// Represents the advanced mode.
    case advanced
}

extension Mode {
    
    /// Returns the localized string value of the mode.
    ///
    /// - Returns: The localized string value of the mode.
    var stringValue: String {
        switch self {
        case .essential: return "ESSENTIAL".localized()
        case .intermediate: return "INTERMEDIATE".localized()
        case .advanced: return "ADVANCED".localized()
        }
    }
    
    /// Returns the localized JSON reference name for the mode.
    /// - Returns: The localized JSON reference name for the mode.
    var jsonReferenceName: String {
        switch self {
        case .essential: return "essential".localized()
        case .intermediate: return "intermediate".localized()
        case .advanced: return "advanced".localized()
        }
    }
    
}
