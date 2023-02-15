//
//  String+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "localized",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized(), args)
    }
}
