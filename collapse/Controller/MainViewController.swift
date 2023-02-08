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
    private var topicList = [TopicElement]()
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewVertical.delegate = self
        loadData()
    }
    
    // MARK: - Actions
    @IBAction func test(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Privates
    private func loadData() {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicTableViewCell", for: indexPath) as? TopicTableViewCell else { return UITableViewCell() }
        
        let topic = topicList[indexPath.section]
        cell.configure(topic: topic)
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TopicViewController") as? TopicViewController {
            vc.topic = topicList[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
