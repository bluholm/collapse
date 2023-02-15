//
//  DetailViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class ItemViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var linksTitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var tableviewLinks: UITableView!
    @IBOutlet var tableHeightConstraint: NSLayoutConstraint!
    private var contentSizeObserver: NSKeyValueObservation?
    var item: Item!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableHeightAddObserver()
        tableviewLinks.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contentSizeObserver = nil
        super.viewWillDisappear(true)
    }
    
    // MARK: - Actions
    @IBAction func didTappedSharedButton(_ sender: Any) {
        var text = item.title+"\n\n"
        text += item.subtitle+"\n\n"
        text += item.description+"\n\n"
        text += "ITEM_LINK_TITLE".localized()
        for link in item.links {
            text += "-"+link.title+"\n"
            text += "-"+link.description+"\n"
        }
        sharePicture(text: [text])
    }
    
    // MARK: - Privates
    private func loadData() {
        linksTitleLabel.text = "ITEM_LINK_TITLE".localized()
        if item.links.isEmpty {
            linksTitleLabel.isHidden = true
            tableviewLinks.isHidden = true
        }
        
        titleLabel.text = item.title
        descriptionTextView.text = item.description
    }
    
    private func tableHeightAddObserver() {
        contentSizeObserver = tableviewLinks.observe(\UITableView.contentSize,
                                                        options: [NSKeyValueObservingOptions.new],
                                                        changeHandler: { _, change in
            if let contentSize = change.newValue {
                self.tableHeightConstraint.constant = contentSize.height
            }
        })
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
        cell.textLabel?.attributedText = WebLink.createLink(link: item.links[indexPath.row].url,
                                                    title: item.links[indexPath.row].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = item.links[indexPath.row].url
            if let url = URL(string: link) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
}
