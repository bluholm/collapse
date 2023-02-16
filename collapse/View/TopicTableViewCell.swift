//
//  TopicTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class TopicTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageTopic: UIImageView!
    @IBOutlet var preparationLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var premiumImage: UIImageView!
    @IBOutlet var percentageCircle: PercentCircleUIView!
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        preparationLabel.text = "STATUS_IN_PROGRESS".localized()
    }

    // MARK: - Public
    func configure(topic: TopicElement, percentage: CGFloat) {
        titleLabel.text = topic.title.uppercased()
        
        if !topic.isPremium || ( SettingsRepository.userIsPremium && topic.isPremium) {
            premiumImage.isHidden = true
        } else {
            premiumImage.isHidden = false
        }
        
        imageTopic.image = UIImage(named: topic.image)
        subtitleLabel.text = topic.subtitle
        percentLabel.text = "\(String(Int(percentage*100)))%"
        
        percentageCircle.percentage = percentage*100
        percentageCircle.setNeedsDisplay()
        percentageCircle.layoutIfNeeded()
        
        if percentage == 1 {
            preparationLabel.text = "STATUS_DONE".localized()
            
            preparationLabel.textColor = UIColor(named: "success")
        }
    }

}
