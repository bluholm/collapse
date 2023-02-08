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
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        preparationLabel.text = "En préparation"
    }

    // MARK: - Public
    func configure(topic: TopicElement) {
        titleLabel.text = topic.title
        imageTopic.image = UIImage(named: topic.image)
        subtitleLabel.text = topic.subtitle
    }

}
