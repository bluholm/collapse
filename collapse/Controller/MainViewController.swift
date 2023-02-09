//
//  ViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var didTappedTopic: [UITapGestureRecognizer]!
    @IBOutlet var scrollViewVertical: UIScrollView!
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var scorePercentLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    private var topicList = [TopicElement]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewVertical.delegate = self
        loadDataFromJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateScorePercent()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
    }
    
    // MARK: - Actions
    @IBAction func test(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Privates
    private func calculateScoreForOneTopic(topic: TopicElement) -> Float {
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
    
    private func calculateScore() -> Float {
        var totalItems = 0
        for topic in topicList {
            totalItems += topic.items.count
        }
        let checkItemsCount = SettingsRepository.checkItem.count
        let result = Double(checkItemsCount) / Double(totalItems)
        return Float(result)
    }
    private func updateScorePercent() {
        let scorePercent = Int(calculateScore()*100)
        scorePercentLabel.text = "\(scorePercent)%"
        scoreProgressView.progress = calculateScore()
    }
    
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
        3
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
        let percentage = calculateScoreForOneTopic(topic: topic)
        cell.configure(topic: topic, percentage: CGFloat(percentage))
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
            vc.topic = topicList[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
