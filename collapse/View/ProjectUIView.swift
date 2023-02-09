//
//  ProjectView.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class ProjectUIView: UIView {

    // MARK: - drawings
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
