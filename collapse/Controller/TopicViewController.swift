//
//  TopicViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class TopicViewController: UIViewController {

    // MARK: - Porperties
    @IBOutlet var scrollView: UIScrollView!
    var topic: TopicElement!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var shortDescriptionTextView: UITextView!
    @IBOutlet var longDescriptionTextView: UITextView!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var tableViewRegular: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    var contentSizeObserver: NSKeyValueObservation?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subtitleLabel.text = topic.subtitle
        imageView.image = UIImage(named: topic.image)
        shortDescriptionTextView.text = loadDescriptionWithDots(description: topic.descriptionShort)
        longDescriptionTextView.text = topic.descriptionLong
        contentSizeObserver = tableViewRegular.observe(\UITableView.contentSize, options: [NSKeyValueObservingOptions.new], changeHandler: { _, change in
                    if let contentSize = change.newValue {
                        self.tableHeight.constant = contentSize.height
                    }
                })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            contentSizeObserver = nil
            super.viewWillDisappear(true)
        }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            var contentRect = CGRect.zero
            
            for view in scrollView.subviews {
                contentRect = contentRect.union(view.frame)
            }
        
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentRect.height)
        
        }
    
    // MARK: - Privates
    private func loadDescriptionWithDots(description: String) -> String {
        if description.count >= 500 {
            return description+"..."
        } else {
            return description
        }
        
    }

}

// MARK: - UITableViewDelegate - UITableViewDataSource
extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray6
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Mes préparations"
        }
        if section == 2 {
            return "mode 2"
        }
        if section == 3 {
            return "Xtreme"
        }
        return ""
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCustomTableViewCell else { return UITableViewCell() }
        cell.configure(item: topic.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        vc.item = topic.items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
