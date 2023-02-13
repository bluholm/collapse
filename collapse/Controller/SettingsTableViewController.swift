//
//  SettingsTableViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

final class SettingsTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet var modeSegmentedControl: UISegmentedControl!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSegmentedControls()
        loadMode()
        self.tableView.rowHeight = 44
    }
    
    // MARK: - Actions
    
    @IBAction func didChangedSegmentedControlState(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SettingsRepository.mode = Mode.essential.stringValue
        case 1:
            SettingsRepository.mode = Mode.intermediate.stringValue
        case 2:
            SettingsRepository.mode = Mode.advanced.stringValue
        default:
            break
        }
        
    }
    
    // MARK: - Privates
    private func loadMode() {
        switch SettingsRepository.mode {
        case Mode.essential.stringValue:
            modeSegmentedControl.selectedSegmentIndex = 0
        case Mode.intermediate.stringValue:
            modeSegmentedControl.selectedSegmentIndex = 1
        case Mode.advanced.stringValue:
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "disclaimerViewController") as? DisclaimerViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 0 {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "thanksViewController") as? ThanksViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
