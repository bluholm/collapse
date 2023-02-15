//
//  Mode.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

enum Mode {
    
    case essential, intermediate, advanced
}

extension Mode {
    
    var stringValue: String {
        switch self {
        case .essential: return "ESSENTIAL".localized()
        case .intermediate: return "INTERMEDIATE".localized()
        case .advanced: return "ADVANCED".localized()
        }
    }
    
}
