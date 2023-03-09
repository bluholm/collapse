//
//  SettingsTableViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

/// This class is a view controller that displays settings in a table view.
final class SettingsTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet var modeSegmentedControl: UISegmentedControl!
    @IBOutlet var disclaimerLabel: UILabel!
    @IBOutlet var thanksLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSegmentedControls()
        loadMode()
    }
    
    // MARK: - Actions
    @IBAction func didChangedSegmentedControlState(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SettingsRepository.mode = Mode.essential.jsonReferenceName
        case 1:
            SettingsRepository.mode = Mode.intermediate.jsonReferenceName
        case 2:
            SettingsRepository.mode = Mode.advanced.jsonReferenceName
        default:
            break
        }
    }
    
    // MARK: - Privates
    private func loadTexts() {
        disclaimerLabel.text = "DISCLAIMER_MENU".localized()
        thanksLabel.text = "THANKS_MENU".localized()
    }
    
    private func loadMode() {
        switch SettingsRepository.mode {
        case Mode.essential.jsonReferenceName:
            modeSegmentedControl.selectedSegmentIndex = 0
        case Mode.intermediate.jsonReferenceName:
            modeSegmentedControl.selectedSegmentIndex = 1
        case Mode.advanced.jsonReferenceName:
            modeSegmentedControl.selectedSegmentIndex = 2
        default:
            modeSegmentedControl.selectedSegmentIndex = 0
         }
        
    }
    private func loadSegmentedControls() {
        modeSegmentedControl.setTitle(Mode.essential.stringValue.capitalized, forSegmentAt: 0)
        modeSegmentedControl.setTitle(Mode.intermediate.stringValue.capitalized, forSegmentAt: 1)
        modeSegmentedControl.setTitle(Mode.advanced.stringValue.capitalized, forSegmentAt: 2)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "thanksViewController") as? ThanksViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            if let url = URL(string: Constants.privacyPolicyLink) {
                    UIApplication.shared.open(url)
                }
        }
        if indexPath.row == 2 {
            if let url = URL(string: Constants.eulaLink) {
                    UIApplication.shared.open(url)
                }
        }
        if indexPath.row == 3 {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "disclaimerViewController") as? DisclaimerViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
