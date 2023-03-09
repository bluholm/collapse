//
//  ProjectView.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

/// This class is a custom UIView that displays information about a project with customizable content.
final class ProjectUIView: UIView {

    // MARK: - drawings
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
