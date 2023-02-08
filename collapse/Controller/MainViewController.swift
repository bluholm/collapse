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
