//
//  ItemCustomTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class ItemCustomTableViewCell: UITableViewCell {

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var switchItem: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: Item) {
        itemLabel.text = item.title
    }

}
