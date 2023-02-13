//
//  Label+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-12.
//

import Foundation
import UIKit

extension UILabel {
    
    func setBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        self.addSubview(blurView)
    }

}
