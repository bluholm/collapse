//
//  TopicViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import UIKit

final class TopicViewController: UIViewController {
    
    // MARK: - Porperties
    // Outlets
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var linksTitleLabel: UILabel!
    @IBOutlet var itemsTitleLabel: UILabel!
    @IBOutlet var scoreTitleLabel: UILabel!
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
    // Constraints
    @IBOutlet var longDescriptionConstraintHeight: NSLayoutConstraint!
    @IBOutlet var contentViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var shortDescriptionHeightConstraint: NSLayoutConstraint!
    // Constants and Variables
    private var contentSizeObserver: NSKeyValueObservation?
    private var filteredItems = [[Item]]()
    private var alertMessage: String!
    private var alertTitle: String!
    private var alertAction: String!
    var topic: TopicElement!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingTopic()
        filteredItems =  PremiumService.loadFilteredItemsForTableView(with: topic)
        tableViewRegular.reloadData()
        self.tableHeightAddObserver()
        self.autoSizeContentView()
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contentSizeObserver = nil
        super.viewWillDisappear(true)
    }
    
    // MARK: - Actions
    @IBAction func didTappedSharedButton(_ sender: Any) {
        var text = topic.title+"\n\n"
        text += topic.subtitle+"\n\n"
        for item in topic.items {
            text += "-"+item.title+"\n"
        }
        text += topic.descriptionShort+"\n\n"
        text += "ITEM_LINK_TITLE".localized()
        for link in topic.links {
            text += "-"+link.title+"\n"
        }
        
        text += topic.descriptionLong+"\n\n"
        shareContent(text: [text])
    }
    
    @IBAction func didTappedInformationButton(_ sender: Any) {
        self.presentSimpleAlert(message: alertMessage, title: alertTitle, actionTitle: alertAction)
    }
    
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
    private func setupView() {
        alertMessage = "MAIN_INFORMATION_BUTTON_MESSAGE".localized()
        alertTitle = "MAIN_INFORMATION_TITLE_MESSAGE".localized()
        alertAction = "MAIN_INFORMATION_ACTION_BUTTON".localized()
        scoreTitleLabel.text = "TOPIC_SCORE_TITLE".localized().capitalized
        descriptionTitleLabel.text = "TOPIC_DESCRIPTION_TITLE".localized()
        itemsTitleLabel.text = "TOPIC_ITEMS_TITLE".localized()
        linksTitleLabel.text = "TOPIC_LINKS_TITLE".localized()
        
    }
    private func updateScorePercent() {
        let score = ScoreService.calculateScoreForOneTopic(with: topic)
        let scorePercent = Int(score*100)
        scorePercentLabel.text = "\(scorePercent)%"
        scoreProgressView.progress = score
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
        shortDescriptionTextView.text = topic.descriptionShort
        longDescriptionTextView.text = topic.descriptionLong
        updateScorePercent()
        if topic.links.isEmpty {
            linkTitleLabel.isHidden = true
            tableViewLink.isHidden = true
            tableViewRegular.isHidden = false
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
            
            let item = filteredItems[indexPath.section][indexPath.row]
            cell.configure(with: item)
            cell.itemId = item.id
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
            cell.textLabel?.attributedText = WebLink.createLink(link: topic.links[indexPath.row].url,
                                                        title: topic.links[indexPath.row].title)
            cell.detailTextLabel?.text = topic.links[indexPath.row].description
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView == tableViewRegular {
            view.tintColor = .white
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewRegular {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "newItemVc") as? NewItemViewController else { return }
            vc.item = filteredItems[indexPath.section][indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let link = topic.links[indexPath.row].url
                if let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableViewRegular {
            switch section {
            case 0:
                return Mode.essential.stringValue.capitalized
            case 1:
                return Mode.intermediate.stringValue.capitalized
            case 2:
                return Mode.advanced.stringValue.capitalized
            default:
                return ""
            }
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
