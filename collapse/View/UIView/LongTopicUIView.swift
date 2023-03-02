//
//  longTopicUIView.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class LongTopicUIView: UIView {

    // MARK: - drawings
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
}
