//
//  DisclaimerViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import UIKit

/// ViewController Allows to display the disclaimer localized
final class DisclaimerViewController: UIViewController {

    @IBOutlet var disclaimerTextlabel: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disclaimerTextlabel.text = "DISCLAIMER_TEXT".localized()
        titleLabel.text = "DISCLAIMER_TITLE".localized()
    }

}
