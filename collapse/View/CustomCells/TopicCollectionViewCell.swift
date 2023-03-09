//
//  TopicCollectionViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-12.
//

import UIKit

/// This class is a collection view cell that displays a topic with customizable content.
final class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var premiumImage: UIImageView!
    
    func configure(with: TopicElement, percentage: CGFloat) {
        
        if PremiumService.isTopicAccessible(topic: with, isUserPremium: SettingsRepository.userIsPremium) {
            premiumImage.isHidden = true
        } else {
            premiumImage.isHidden = false
        }
        
        progressLabel.text = "STATUS_IN_PROGRESS".localized()
        titleLabel.text = with.title.uppercased()
        subTitleLabel.text = with.subtitle
        image.image = UIImage(named: with.image)
        
        if percentage == 1 {
            progressLabel.text = "STATUS_DONE".localized()
            progressLabel.textColor = UIColor(named: "success")
        }
    }
}
