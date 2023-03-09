//
//  percentCircleUIView.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

/// This class is a custom UIView that displays a circle graph with a percentage value.
final class PercentCircleUIView: UIView {
    
    // MARK: - properties
    var percentage: CGFloat = 87.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 5
        let startAngle: CGFloat = 3 * .pi / 2
        let endAngle: CGFloat = startAngle + 2 * .pi * (percentage / 100)
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        path.lineWidth = 2

        if percentage == 0 {
                UIColor(named: "MainGray5")!.setStroke()
                path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle + 2 * .pi, clockwise: true)
            } else {
                UIColor(named: "MainColor")!.setStroke()
            }
        
        path.stroke()
    }
}
