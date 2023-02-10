//
//  SettingsTableViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
