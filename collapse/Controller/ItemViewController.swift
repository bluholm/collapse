//
//  NewItemViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-16.
//

import UIKit
import WebKit

/// This class is a view controller that displays details about a single ``Item``.
final class ItemViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var item: Item!
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @IBAction func didSharedButtonTapped(_ sender: Any) {
        var text = item.title+"\n\n"
        for content in item.content {
            text += "-"+content.value+"\n"
        }
        text += "ITEM_LINK_TITLE".localized()
        shareContent(text: [text])
    }
    
    // MARK: - Privates
    private func setupView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        titleLabel.text = item.title
    }
    
}

extension ItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item.content.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if item.content[indexPath.row].type == "image" {
            return 300
        }
        if item.content[indexPath.row].type == "text" || item.content[indexPath.row].type == "bullet" {
            let text = item.content[indexPath.row].value
            let font = UIFont.systemFont(ofSize: 17)
            let constraintRect = CGSize(width: tableView.bounds.width - 30, height: .greatestFiniteMagnitude)
            let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
            let height = ceil(boundingBox.height) + 30
            return height
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if item.content[indexPath.row].type == "bullet" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "bulletCell", for: indexPath) as? BulletItemTableViewCell else { return UITableViewCell() }
            cell.configure(with: item.content[indexPath.row].value)
            return cell
        }
        if item.content[indexPath.row].type == "text" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextItemTableViewCell  else { return UITableViewCell() }
            cell.configure(with: item.content[indexPath.row].value)
            return cell
        }
        if item.content[indexPath.row].type == "image" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageItemTableViewCell  else { return UITableViewCell() }
            cell.configure(with: item.content[indexPath.row].value)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
