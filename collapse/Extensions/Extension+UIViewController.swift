//
//  UIViewController+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-14.
//

import Foundation
import UIKit

extension UIViewController {
    
    func shareContent(text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        present(activityController, animated: true)
    }
}
