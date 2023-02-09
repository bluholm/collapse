//
//  DetailViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class DetailViewController: UIViewController {

    var item: Item!
    @IBOutlet var linksTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func createLink(link: String, description: String) -> NSAttributedString {
          let text = NSAttributedString(string: description)
          let attachment = NSTextAttachment()
          attachment.image = UIImage(systemName: "link")
          let attachmentString = NSAttributedString(attachment: attachment)
          let finalString = NSMutableAttributedString(attributedString: text)
          finalString.append(attachmentString)
          let range = NSRange(location: text.length, length: attachmentString.length)
          finalString.addAttribute(.link, value: link, range: range)
          return finalString
        }

        linksTitleLabel.attributedText = createLink(link: "http://google.com", description: "mark")

    }

}
