//
//  MainViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit
import Firebase

/// This page is the main page, the viewcontroller on which the initial controller is set up during the second connection to the application.
/// It includes all the general menus: settings, topics, etc....
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
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var premiumBarItem: UIBarButtonItem!
    @IBOutlet var tipsUIView: UIView!
    @IBOutlet var tipsTitleLabel: UILabel!
    @IBOutlet var tipsDescriptionLabel: UILabel!
    @IBOutlet var tipsViewActivityController: UIActivityIndicatorView!
    
    // variables & constants
    private var topicList = [TopicElement]()
    private var tipsList = [Tips]()
    private var topichighlight = [TopicElement]()
    private var alertMessage: String!
    private var alertTitle: String!
    private var alertAction: String!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromJson()
        setUpView()
        fetchTipsFireBase()
        loadActionsPremium()
        addObserverNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHilightTopicDependingPremium()
        updateScorePercent()
        deselectDataTableView()
        tableView.reloadData()
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
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
    private func fetchTipsFireBase() {
        tipsViewActivityController.isHidden = false
        Firebase().readData { data in
            DispatchQueue.main.async {
                for child in data.children {
                    
                    guard let snapshot = child as? DataSnapshot else {
                        return
                    }
                    guard let value = snapshot.value as? [String: AnyObject],
                          let title = value["title"] as? String,
                          let langage = value["langage"] as? String,
                          let icon = value["icon"] as? String,
                          let idTips = value["id"] as? String,
                          let highlight = value["highlight"] as? Bool,
                          let description = value["description"] as? String
                    else {
                        return
                    }
                    let dataTip = Tips(title: title, highlight: highlight, icon: icon, langage: langage, id: idTips, description: description)
                    
                    self.tipsList.append(dataTip)
                    if highlight && langage == SettingScheme.langage() {
                        self.tipsViewActivityController.isHidden = true
                        self.updateTipsUiView()
                    }
                }
            }
            
        }
    }
    
    private func updateTipsUiView() {
        tipsTitleLabel.text = tipsList[0].title
        tipsDescriptionLabel.text = tipsList[0].description
    }
    
    private func addObserverNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationWhenDismiss), name: NSNotification.Name("dismissModal"), object: nil)
    }
    
    private func deselectDataTableView() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
    }
    
    private func loadHilightTopicDependingPremium() {
        let topicsByScore = ScoreService.sortTopicsByScore(with: topicList, using: 3, checkedItems: SettingsRepository.checkItem)
        let topicByIsUser = ScoreService.sortTopicElementsByIsPremium(topicList)
        topichighlight = SettingsRepository.userIsPremium ? topicsByScore : topicByIsUser
    }
    
    private func loadActionsPremium() {
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    private func updateScorePercent() {
        let score = ScoreService.calculateTotalScore(for: topichighlight, checkedItems: SettingsRepository.checkItem)
        var scorePercent = 0
        scorePercent = Int(score*100)
        scorePercentLabel.text = "\(scorePercent)%"
        scoreProgressView.progress = score
    }
    
    private func loadDataFromJson() {
        JsonService.parse(file: SettingScheme.returnNameSchemeLangageFile()) { result in
            switch result {
            case .success(let table):
                self.topicList = table
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpView() {
        tipsViewActivityController.isHidden = false
        tipsViewActivityController.startAnimating()
        tipsUIView.layer.cornerRadius = 8
        tipsTitleLabel.text = ""
        tipsDescriptionLabel.text = ""
        projectTitleLabel.text = "MAIN_PROJECT_TITLE".localized()
        projectSubtitleLabel.text = "MAIN_PROJECT_SUBTITLE".localized()
        projectTitleLabel.text = "MAIN_PROJECT_GENERAL_TITLE".localized()
        projectFirstSectionLabel.text = "MAIN_PROJECT_FIRST_SECTION_TITLE".localized()
        projectSecondSectionLabel.text = "MAIN_PROJECT_SECOND_SECTION_TITLE".localized()
        projectViewAllButton.setTitle("MAIN_BUTTON_VIEW_ALL".localized(topicList.count), for: .normal)
        alertMessage = "MAIN_INFORMATION_BUTTON_MESSAGE".localized()
        alertTitle = "MAIN_INFORMATION_TITLE_MESSAGE".localized()
        alertAction = "MAIN_INFORMATION_ACTION_BUTTON".localized()
#if DEBUG
#else
        if #available(iOS 16.0, *) {
            premiumBarItem.isHidden =  SettingsRepository.userIsPremium ? true : false
        } else {
            premiumBarItem.isEnabled =  SettingsRepository.userIsPremium ? true : false
        }
#endif
        
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
        let percentage = ScoreService.calculateScoreForOneTopic(for: topic, checkedItems: SettingsRepository.checkItem)
        cell.configure(topic: topic, percentage: CGFloat(percentage))
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedtopic = topichighlight[indexPath.section]
        if PremiumService.isTopicAccessible(topic: selectedtopic, isUserPremium: SettingsRepository.userIsPremium) {
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
        let percentage = ScoreService.calculateScoreForOneTopic(for: topic, checkedItems: SettingsRepository.checkItem)
        cell.configure(with: topicList[indexPath.row], percentage: CGFloat(percentage))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedtopic = topicList[indexPath.row]
        if PremiumService.isTopicAccessible(topic: selectedtopic, isUserPremium: SettingsRepository.userIsPremium) {
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
}
