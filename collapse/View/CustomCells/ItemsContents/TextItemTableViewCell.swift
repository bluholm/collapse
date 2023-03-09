//
//  TextItemTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-17.
//

import UIKit

/// This class is a table view cell that displays a text item in ``Content``
class TextItemTableViewCell: UITableViewCell {
    
    var myTextLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        myTextLabel.numberOfLines = 0
        myTextLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(myTextLabel)
        
        NSLayoutConstraint.activate([
            myTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            myTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(with text: String) {
        myTextLabel.text = text
    }
    
}
