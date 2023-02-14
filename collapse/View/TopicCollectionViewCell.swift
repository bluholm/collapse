//
//  TopicCollectionViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-12.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    func configure(with: TopicElement, percentage: CGFloat) {
        progressLabel.text = "En préparation"
        titleLabel.text = with.title.uppercased()
        subTitleLabel.text = with.subtitle
        image.image = UIImage(named: with.image)
        
        if percentage == 1 {
            progressLabel.text = "complete"
            progressLabel.textColor = UIColor(named: "success")
        }
    }
}
