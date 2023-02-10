//
//  ViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var scrollViewVertical: UIScrollView!
    @IBOutlet var scoreProgressView: UIProgressView!
    @IBOutlet var scorePercentLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    private var topicList = [TopicElement]()
    private var topichighlight = [TopicElement]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewVertical.delegate = self
        loadDataFromJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topichighlight = ScoreService.loadHighlightTopics(with: topicList, for: 3)
        updateScorePercent()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func test(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Privates
    
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
            vc.topic = topichighlight[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
