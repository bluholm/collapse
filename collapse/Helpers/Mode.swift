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
        case .essential: return "essential"
        case .intermediate: return "intermediate"
        case .advanced: return "advanced"
        }
    }
    
}
