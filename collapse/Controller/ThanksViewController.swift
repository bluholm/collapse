//
//  ThanksViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import UIKit

/// This class is a view controller that displays a thank-you message after the user completes an action.
final class ThanksViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var allThanksTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadThanks()
    }
    
    // MARK: - Privates
    private func loadThanks() {
        guard let path = Bundle.main.path(forResource: "thanks", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            // swiftlint: disable force_cast
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            if let unsplashArray = jsonData["unsplash"] as? [String] {
                var formattedText = ""
                for unsplashLink in unsplashArray {
                    let username = getUsernameFromUnsplashLink(unsplashLink)
                    formattedText += "@\(username), "
                }
                allThanksTextView.text = "THANKS_TEXT".localized()
                allThanksTextView.text += "\n\n"
                allThanksTextView.text += formattedText
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func setupView() {
        allThanksTextView.font = UIFont.systemFont(ofSize: 12)
        allThanksTextView.textAlignment = .justified
        titleLabel.text = "THANKS_TITLE".localized()
        
    }
    private func getUsernameFromUnsplashLink(_ link: String) -> String {
        let components = link.components(separatedBy: "@")
        if components.count > 1 {
            return components[1]
        }
        return ""
    }
    
}
