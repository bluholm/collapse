//
//  ImageItemTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-17.
//

import UIKit

/// This class is a table view cell that displays an image item in ``Content``
final class ImageItemTableViewCell: UITableViewCell {

    var myImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.contentMode = .scaleAspectFit
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(myImageView)
        
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 300)
                ])
    }
    
    func configure(with name: String) {
        myImageView.image = UIImage(named: name)
    }
    
}
