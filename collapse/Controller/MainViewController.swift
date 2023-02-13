//
//  ViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var premiumTipsView: UIView!
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var scorePercentLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    private var topicList = [TopicElement]()
    private var topichighlight = [TopicElement]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        loadDataFromJson()
        checkIfPremium()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name("dismissModal"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topichighlight = ScoreService.loadHighlightTopics(with: topicList, using: 3)
        updateScorePercent()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        tableView.reloadData()
        
    }
    
    // MARK: - Actions
    
    @objc func handleNotification() {
       checkIfPremium()
    }
     
    @IBAction func didTapPremium(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "premiumViewController") as? PremiumViewController {
            present(vc, animated: true)
        }
    }
    
    @IBAction func didTappedButtonInformation(_ sender: Any) {
        // swiftlint: disable line_length
        let message = "Les calculs de score sont effectués en fonction des modes sélectionnés pour chaque sujet. Si vous avez coché tous les éléments dans le mode avancé, vous obtiendrez un score de 100%. il faut donc être en mode advanced pour obtenir le score maximal"
        self.presentSimpleAlert(message: message, title: "Informations", actionTitle: "Ok")
    }
    
    @IBAction func test(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Privates
    
    private func checkIfPremium() {
        if SettingsRepository.userIsPremium {
            premiumTipsView.isHidden = true
        } else {
            premiumTipsView.isHidden = false
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
        
        if !selectedtopic.isPremium || ( SettingsRepository.userIsPremium && selectedtopic.isPremium) {
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
