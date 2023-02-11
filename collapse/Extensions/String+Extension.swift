//
//  String+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation

extension String {
    
    /// Localize at tableName "Localizable" on "bundle.main"
    /// "hello %@! you are %d years old".localized("Mike", 25)/// How to use
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized(), args)
    }
}
