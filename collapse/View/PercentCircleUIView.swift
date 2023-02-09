//
//  percentCircleUIView.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

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
        UIColor(named: "SecondColor")!.setStroke()

        path.stroke()
    }
}
