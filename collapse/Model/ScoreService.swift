//
//  ScoreService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation

class ScoreService {
    
    static func calculateScoreForOneTopic(with: TopicElement) -> Float {
        let total = with.items.count
        var check = 0
        for item in with.items {
            for (key, _) in SettingsRepository.checkItem where item.id == key {
                        check += 1
                    }
        }
        let result = Double(check)/Double(total)
        return Float(result)
    }
    
    static func calculateTotalScore(with: [TopicElement]) -> Float {
        var totalItems = 0
        for topic in with {
            totalItems += topic.items.count
        }
        let checkItemsCount = SettingsRepository.checkItem.count
        let result = Double(checkItemsCount) / Double(totalItems)
        return Float(result)
    }
    
    static func loadHighlightTopics(with: [TopicElement], for: Int) -> [TopicElement] {
        var table = [String: Float]()
        for topicElement in with {
            table[topicElement.uid] = calculateScoreForOneTopic(with: topicElement)
        }
        table = table.filter { $0.value != 1.0 }
        let sortedDict = sortDictionaryByValue(dictionary: table, isOrderedBefore: { $0 > $1 })
        let firstThree = sortedDict.prefix(3)
        var newDictionary = [String: Float]()
        for (key, value) in firstThree {
            newDictionary[key] = value
        }
        return with.filter { newDictionary.keys.contains($0.uid) }
    }
    
    static func sortDictionaryByValue<Key, Value>(dictionary: [Key: Value], isOrderedBefore: (Value, Value) -> Bool) -> [Key: Value] {
        let sortedTable = dictionary.sorted(by: { isOrderedBefore($0.value, $1.value) })
        var sortedDict: [Key: Value] = [:]
        for (key, value) in sortedTable {
            sortedDict[key] = value
        }
        return sortedDict
    }
    
    static func loadFilteredItemsForTableView(with: TopicElement) -> [[Item]] {
        var filteredItems = [[Item]]()
        let regularItems = with.items.filter { $0.mode == Constants.modes[0] }.sorted { $0.title < $1.title }
        let intermediateItems = with.items.filter { $0.mode == Constants.modes[1] }.sorted { $0.title < $1.title }
        let advancedItems = with.items.filter { $0.mode == Constants.modes[2] }.sorted { $0.title < $1.title }
        
        if !regularItems.isEmpty {
            filteredItems.append(regularItems)
        }
        if !intermediateItems.isEmpty {
            filteredItems.append(intermediateItems)
        }
        if !advancedItems.isEmpty {
            filteredItems.append(advancedItems)
        }
        return filteredItems
    }

}
