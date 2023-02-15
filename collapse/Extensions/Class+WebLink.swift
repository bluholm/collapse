//
//  String+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation
import UIKit

final class WebLink {
    
    static func createLink(link: String, title: String) -> NSAttributedString {
        let color: UIColor = .systemBlue
        let linkString = NSMutableAttributedString(string: "[\(link.components(separatedBy: ".")[1]).com] ")
        let linkImage = NSTextAttachment()
        linkImage.image = UIImage(systemName: "link")
        linkString.append(NSAttributedString(attachment: linkImage))
        linkString.append(NSAttributedString(string: " \(title)"))
        
        let range = NSRange(location: 0, length: linkString.length - title.count - 2)
        linkString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        return linkString
    }
    
}
