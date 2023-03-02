//
//  ItemCustomTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class ItemCustomTableViewCell: UITableViewCell {

    // MARK: - properties
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var switchItem: UISwitch!
    var itemId: String?
        
    // MARK: - Public
    func configure(with: Item) {
        if SettingsRepository.checkItem.keys.contains(with.id) {
            switchItem.setOn(true, animated: true)
        } else {
            switchItem.setOn(false, animated: true)
        }
        itemLabel.text = with.title
    }

}
