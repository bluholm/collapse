//
//  TopicViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class TopicViewController: UIViewController {
    
    // MARK: - Porperties
    //Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var shortDescriptionTextView: UITextView!
    @IBOutlet var longDescriptionTextView: UITextView!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var tableViewLink: UITableView!
    @IBOutlet var tableViewRegular: UITableView!
    @IBOutlet var scorePercentLabel: UILabel!
    @IBOutlet var linkTitleLabel: UILabel!
    //Constraints
    @IBOutlet var longDescriptionConstraintHeight: NSLayoutConstraint!
    @IBOutlet var contentViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var shortDescriptionHeightConstraint: NSLayoutConstraint!
    //constants and variables
    private var contentSizeObserver: NSKeyValueObservation?
    private var filteredItems = [[Item]]()
    private var modes = ["essential", "intermediate", "advanced"]
    var topic: TopicElement!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingTopic()
        self.tableHeightAddObserver()
        self.autoSizeContentView()
        self.loadFilteredItemsForTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contentSizeObserver = nil
        super.viewWillDisappear(true)
    }
    
    // MARK: - Actions
    
    @IBAction func didSwitchedItem(_ sender: UISwitch) {
        guard let cell = sender.superview?.superview as? ItemCustomTableViewCell, let itemId = cell.itemId else { return }
        if sender.isOn {
            SettingsRepository.checkItem[itemId] = true
        } else {
            SettingsRepository.checkItem.removeValue(forKey: itemId)
        }
        updateScorePercent()
    }
    
    // MARK: - Privates
    private func updateScorePercent() {
        let scorePercent = Int(calculateScore()*100)
        scorePercentLabel.text = "\(scorePercent)%"
        scoreProgressView.progress = calculateScore()
    }
    
    private func calculateScore() -> Float {
        let total = topic.items.count
        var check = 0
        for item in topic.items {
            for (key, _) in SettingsRepository.checkItem where item.id == key {
                        check += 1
                    }
        }
        let result = Double(check)/Double(total)
        return Float(result)
    }
    
    private func loadFilteredItemsForTableView() {
        let regularItems = topic.items.filter { $0.mode == modes[0] }.sorted { $0.title < $1.title }
        let intermediateItems = topic.items.filter { $0.mode == modes[1] }.sorted { $0.title < $1.title }
        let advancedItems = topic.items.filter { $0.mode == modes[2] }.sorted { $0.title < $1.title }
        
        if !regularItems.isEmpty {
            filteredItems.append(regularItems)
        }
        if !intermediateItems.isEmpty {
            filteredItems.append(intermediateItems)
        }
        if !advancedItems.isEmpty {
            filteredItems.append(advancedItems)
        }
        tableViewRegular.reloadData()
    }
    
    private func textViewHeightCalcultate(textView: UITextView) -> CGFloat {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newSize.height
    }
    
    private func autoSizeContentView() {
        let blocShortDecriptionHeight = textViewHeightCalcultate(textView: shortDescriptionTextView)
        shortDescriptionHeightConstraint.constant = blocShortDecriptionHeight
        let blocLongDecriptionHeight = textViewHeightCalcultate(textView: longDescriptionTextView)
        longDescriptionConstraintHeight.constant = blocLongDecriptionHeight
        let bloc1Height = CGFloat(32+250+16+80)
        let blocTitleHeight = CGFloat(24+24+8)*3
        let blocTableViewSectionsHeight = CGFloat(3*60)
        let blocTableViewRowsHeight = CGFloat(topic.items.count*50)
        let blocTableViewLinksRowsHeight = CGFloat(topic.links.count*50)
        let blocTableViewLinksSectionHeight = CGFloat(20)
        var total = bloc1Height+blocShortDecriptionHeight+blocTitleHeight
        total += blocTableViewRowsHeight+blocTableViewSectionsHeight+blocLongDecriptionHeight
        total += blocTableViewLinksRowsHeight+blocTableViewLinksSectionHeight
        contentViewConstraintHeight.constant = total
    }
    
    private func tableHeightAddObserver() {
        contentSizeObserver = tableViewRegular.observe(\UITableView.contentSize,
                                                        options: [NSKeyValueObservingOptions.new],
                                                        changeHandler: { _, change in
            if let contentSize = change.newValue {
                self.tableHeight.constant = contentSize.height
            }
        })
    }
    
    private func loadingTopic() {
        subtitleLabel.text = topic.subtitle
        imageView.image = UIImage(named: topic.image)
        shortDescriptionTextView.text = loadDescriptionWithDots(description: topic.descriptionShort)
        longDescriptionTextView.text = topic.descriptionLong
        updateScorePercent()
        if topic.links.isEmpty {
            linkTitleLabel.isHidden = true
            tableViewLink.isHidden = true
            tableViewRegular.isHidden = false
        }
    }
    
    private func loadDescriptionWithDots(description: String) -> String {
        if description.count >= 500 {
            return description+"slide bottom too see more "
        } else {
            return description
        }
    }
}

// MARK: - UITableViewDelegate - UITableViewDataSource
extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewRegular {
            return filteredItems.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewRegular {
            return filteredItems[section].isEmpty ? 0 : filteredItems[section].count
        }
        return topic.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewRegular {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCustomTableViewCell else { return UITableViewCell() }
            
            guard indexPath.row < filteredItems.count else { return UITableViewCell() }
            let item = filteredItems[indexPath.section][indexPath.row]
            cell.configure(with: item)
            cell.itemId = item.id
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
            cell.textLabel?.text = topic.links[indexPath.row].url
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView == tableViewRegular {
            view.tintColor = .systemGray6
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewRegular {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
            vc.item = filteredItems[indexPath.section][indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableViewRegular {
            return modes[section].capitalized
        }
        return ""
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableViewRegular {
            return 60
        }
        return 20
    }
}
