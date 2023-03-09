//
//  BulletItemTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-17.
//

import UIKit

/// This class is a table view cell that displays a bullet point item in ``Content``
class BulletItemTableViewCell: UITableViewCell {

    let bulletImageView = UIImageView()
    let myTextLabel = UILabel()
            
    override func awakeFromNib() {
        super.awakeFromNib()
        bulletImageView.translatesAutoresizingMaskIntoConstraints = false
        bulletImageView.image = UIImage(systemName: "circle.fill")
        bulletImageView.tintColor = UIColor(named: "mainColor")
        
        myTextLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.lineBreakMode = .byWordWrapping
        myTextLabel.textAlignment = .justified
        myTextLabel.numberOfLines = 0
                
        contentView.addSubview(bulletImageView)
        contentView.addSubview(myTextLabel)
        NSLayoutConstraint.activate([
                   bulletImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                   bulletImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                   bulletImageView.widthAnchor.constraint(equalToConstant: 10),
                   bulletImageView.heightAnchor.constraint(equalToConstant: 10),
                   myTextLabel.leadingAnchor.constraint(equalTo: bulletImageView.trailingAnchor, constant: 10),
                   myTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                   myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                   myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
               ])
        
    }
    
    func configure(with text: String) {
        myTextLabel.text = text
    }

}
