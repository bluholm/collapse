//
//  SearchViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-13.
//

import UIKit

/// This class is a view controller that allows the user to search for items.
final class SearchViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    private var topicList = [TopicElement]()
    private var filteredTopic = [TopicElement]()
    private var searchWord: String!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromJson()
    }

    // MARK: - Privates
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: filteredTopic[indexPath.row], word: searchWord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedtopic = filteredTopic[indexPath.row]
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

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchText
      filteredTopic = searchText.isEmpty ? topicList : topicList.flatMap({ (topic: TopicElement) -> [TopicElement] in
        let items = topic.items.filter({ (item: Item) -> Bool in
          return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ||
                 topic.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ||
                 topic.descriptionShort.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ||
                 topic.descriptionLong.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
          return items.isEmpty ? [] : [TopicElement(uid: topic.uid,
                                                    title: topic.title,
                                                    subtitle: topic.subtitle,
                                                    image: topic.image,
                                                    descriptionShort: topic.descriptionShort,
                                                    descriptionLong: topic.descriptionLong,
                                                    items: items,
                                                    links: topic.links,
                                                    isPremium: topic.isPremium)]
      })

      tableView.reloadData()
    }

}
