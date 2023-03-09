//
//  SettingsViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import UIKit

/// This class is a view controller that displays app settings and allows the user to customize them.
final class SettingsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var modeUITextView: UITextView!
    @IBOutlet var titleTextLabel: UILabel!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        modeUITextView.text = "SETTING_ALL_TEXT".localized()
        titleTextLabel.text = "SETTING_ALL_TITLE".localized()
    }
    
}
