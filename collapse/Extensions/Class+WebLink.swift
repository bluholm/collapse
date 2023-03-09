//
//  String+Extension.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation
import UIKit

/// WebLink is a final class that provides functionality to create a attributed string with a hyperlink.
///
/// The WebLink class provides two static functions, createLink and extractDomainName.
/// The createLink function creates a NSAttributedString object that contains a hyperlink with the provided URL and title.
///  The extractDomainName function extracts the domain name from the provided URL string.
///
final class WebLink {
    
    /// Creates an attributed string with a link and a title.
    ///
    ///
    /// This method creates an attributed string that displays a link and a title.
    /// The link is extracted from the URL provided in the `link` parameter, and is displayed within square brackets.
    /// The title is displayed immediately after the link, preceded by a link icon. The color of the link text is set to system blue.
    ///
    /// - Parameters:
    ///     - link: The link to be displayed in the attributed string.
    ///     - title: The title to be displayed in the attributed string.
    ///
    /// - Returns: An `NSAttributedString` object that represents the link and title.

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
    
    /// Extracts the domain name from a given URL.
    ///
    /// - Parameter url: The URL to extract the domain name from.
    ///
    /// - Returns: A string representing the domain name of the URL. Returns an empty string if the URL is invalid.

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
