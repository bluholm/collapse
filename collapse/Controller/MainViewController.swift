//
//  MainViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    // IBoutlets
    @IBOutlet var scorePercentLabel: UILabel!
    @IBOutlet var projectTitleLabel: UILabel!
    @IBOutlet var projectSubtitleLabel: UILabel!
    @IBOutlet var projectGeneralTitleLabel: UILabel!
    @IBOutlet var projectFirstSectionLabel: UILabel!
    @IBOutlet var projectSecondSectionLabel: UILabel!
    @IBOutlet var projectViewAllButton: UIButton!
    @IBOutlet var premiumButton: UIButton!
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var tableView: UITableView!
    // variables & constants
    private var topicList = [TopicElement]()
    private var topichighlight = [TopicElement]()
    private var alertMessage: String!
    private var alertTitle: String!
    private var alertAction: String!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromJson()
        loadActionsPremium()
        setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationWhenDismiss), name: NSNotification.Name("dismissModal"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topichighlight = SettingsRepository.userIsPremium ? ScoreService.sortTopicsByScore(with: topicList, using: 3) : ScoreService.sortTopicElementsByIsPremium(topicList)
        updateScorePercent()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        tableView.reloadData()
        
    }
    
    // MARK: - Actions
    @objc func handleNotificationWhenDismiss() {
       loadActionsPremium()
    }
     
    @IBAction func didTapPremiumButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "premiumViewController") as? PremiumViewController {
            present(vc, animated: true)
        }
    }
    
    @IBAction func didTappedInformationButton(_ sender: Any) {
        self.presentSimpleAlert(message: alertMessage, title: alertTitle, actionTitle: alertAction)
    }
    
    // MARK: - Privates
    private func loadActionsPremium() {
        if SettingsRepository.userIsPremium {
            premiumButton.isHidden = true
        } else {
            premiumButton.isHidden = false
        }
        tableView.reloadData()
    }
    
    private func updateScorePercent() {
        let score = ScoreService.calculateTotalScore(with: topichighlight)
        let scorePercent = Int(score*100)
        scorePercentLabel.text = "\(scorePercent)%"
        scoreProgressView.progress = score
    }
    
    private func loadDataFromJson() {
        JsonService.parse(file: SettingScheme.loadLangageScheme()) { result in
            switch result {
            case .success(let table):
                self.topicList = table
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpView() {
        projectTitleLabel.text = "MAIN_PROJECT_TITLE".localized()
        projectSubtitleLabel.text = "MAIN_PROJECT_SUBTITLE".localized()
        premiumButton.setTitle("MAIN_BUTTON_PREMIUM_TITLE".localized(), for: .normal)
        projectTitleLabel.text = "MAIN_PROJECT_GENERAL_TITLE".localized()
        projectFirstSectionLabel.text = "MAIN_PROJECT_FIRST_SECTION_TITLE".localized()
        projectSecondSectionLabel.text = "MAIN_PROJECT_SECOND_SECTION_TITLE".localized()
        projectViewAllButton.setTitle("MAIN_BUTTON_VIEW_ALL".localized(topicList.count), for: .normal)
        alertMessage = "MAIN_INFORMATION_BUTTON_MESSAGE".localized()
        alertTitle = "MAIN_INFORMATION_TITLE_MESSAGE".localized()
        alertAction = "MAIN_INFORMATION_ACTION_BUTTON".localized()
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        topichighlight.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicTableViewCell", for: indexPath) as? TopicTableViewCell else { return UITableViewCell() }
        
        let topic = topichighlight[indexPath.section]
        let percentage = ScoreService.calculateScoreForOneTopic(with: topic)
        cell.configure(topic: topic, percentage: CGFloat(percentage))
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedtopic = topichighlight[indexPath.section]
        if PremiumService.isTopicAccessible(topic: selectedtopic) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
                vc.topic = selectedtopic
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "premiumViewController") as? PremiumViewController {
                present(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.selectedBackgroundView = backgroundView
    }
    
}

// MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
        let topic = topicList[indexPath.row]
        let percentage = ScoreService.calculateScoreForOneTopic(with: topic)
        cell.configure(with: topicList[indexPath.row], percentage: CGFloat(percentage))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
            vc.topic = topicList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
