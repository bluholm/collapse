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
        let url: String = extractDomainName(from: link)
        let linkString = NSMutableAttributedString(string: "[\(url)] ")
        let linkImage = NSTextAttachment()
        linkImage.image = UIImage(systemName: "link")
        linkString.append(NSAttributedString(attachment: linkImage))
        linkString.append(NSAttributedString(string: " \(title)"))
        
        let range = NSRange(location: 0, length: linkString.length - title.count - 2)
        linkString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        return linkString
    }
    
    static func extractDomainName(from url: String) -> String {
        guard let url = URL(string: url) else {
            return ""
        }
        if let host = url.host {
            let components = host.components(separatedBy: ".")
            if components.count >= 2 {
                return components[components.count - 2] + "." + components[components.count - 1]
            } else {
                return host
            }
        }
        return ""
    }

}
