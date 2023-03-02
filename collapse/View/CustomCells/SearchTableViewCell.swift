//
//  SearchTableViewCell.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-14.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageUIImageView: UIImageView!
    @IBOutlet var premiumImage: UIImageView!
    
    // MARK: - Publics
    func configure(with: TopicElement, word: String) {

        titleLabel.text = with.title.uppercased()
        imageUIImageView.image = UIImage(named: with.image)
        
        var itemsText = ""
        for value in with.items {
            itemsText += "checklist:"+value.title
            itemsText += " & "+value.subtitle
            itemsText += " - content - "
            for content in value.content {
                itemsText += content.value
                itemsText += "\n\n"
            }
        }
        
        let fullText = with.title+" & "+with.subtitle+", description: "+with.descriptionShort+" & description : "+with.descriptionLong+itemsText
        let text = changeString(text: fullText, word: word, length: 35)
        descriptionLabel.attributedText = highlightWord(in: text, word: word)
        
        if word.isEmpty {
            descriptionLabel.attributedText = NSAttributedString(string: with.subtitle)
        }
        
        if PremiumService.isTopicAccessible(topic: with) {
            premiumImage.isHidden = true
        } else {
            premiumImage.isHidden = false
        }
    }
    
    func changeString(text: String, word: String, length: Int) -> String {
        let range = text.range(of: word, options: .caseInsensitive)
        guard let foundRange = range else {
            return ""
        }
        
        let startIndexB = text.distance(from: text.startIndex, to: foundRange.lowerBound)
        let endIndexA = text.distance(from: text.startIndex, to: foundRange.upperBound)
        
        var startIndexA = startIndexB - length
        if startIndexA < 0 {
            startIndexA = 0
        }
        
        var endIndexB = endIndexA + length
        if endIndexB > text.count {
            endIndexB = text.count
        }
        
        let startIndexString = text[text.index(text.startIndex, offsetBy: startIndexA)..<text.index(text.startIndex, offsetBy: startIndexB)]
        let endIndexString = text[text.index(text.startIndex, offsetBy: endIndexA)..<text.index(text.startIndex, offsetBy: endIndexB)]
        
        return "...\(startIndexString)\(word)\(endIndexString)..."
    }

    func highlightWord(in text: String, word: String) -> NSAttributedString {
      let attributedString = NSMutableAttributedString(string: text)
      let range = (text as NSString).range(of: word, options: .caseInsensitive)
      attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
      return attributedString
    }
}
