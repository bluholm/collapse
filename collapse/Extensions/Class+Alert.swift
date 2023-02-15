//
//  Class+Alert.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentSimpleAlert(message: String, title: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionSend = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(actionSend)
        present(alert, animated: true)
    }
}
