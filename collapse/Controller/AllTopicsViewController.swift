//
//  AllTopicsViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import UIKit

class AllTopicsViewController: UIViewController {

    // MARK: - Properties
    private var topicList = [TopicElement]()
    @IBOutlet var tableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
    }
    
    // MARK: - Privates
    
    private func loadDataFromJson() {
        JsonService.parse(file: "french") { result in
            switch result {
            case .success(let table):
                self.topicList = table
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension AllTopicsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        topicList.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicTableViewCell", for: indexPath) as? TopicTableViewCell else { return UITableViewCell() }
        
        let topic = topicList[indexPath.section]
        let percentage = ScoreService.calculateScoreForOneTopic(with: topic)
        cell.configure(topic: topic, percentage: CGFloat(percentage))
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedtopic = topicList[indexPath.section]
        if !selectedtopic.isPremium || ( SettingsRepository.userIsPremium && selectedtopic.isPremium) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
                vc.topic = topicList[indexPath.section]
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
