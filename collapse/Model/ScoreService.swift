//
//  ScoreService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-10.
//

import Foundation

/// ScoreService is the major Model Class who calculate all score topic , items , percents .
final class ScoreService {
    
    /// Calculates the score for one topic based on the number of checked items.
    /// - Parameters:
    ///   - topic: The topic element for which the score needs to be calculated.
    ///   - checkedItems: Listed items checked by users.
    /// - Returns: The calculated score for the topic as a floating-point number.
    static func calculateScoreForOneTopic(for topic: TopicElement, checkedItems: [String: Bool] ) -> Float {
        let total = topic.items.count
        var check = 0
        for item in topic.items {
            for (key, _) in checkedItems where item.id == key {
                        check += 1
                    }
        }
        let result = Double(check)/Double(total)
        return Float(result)
    }
    
    /// This function calculates the total score based on an array of topic elements.
    ///
    /// The function iterates through each topic element and calculates the total number of items.
    /// It then calculates the score based on the ratio of the number of items to the number of check items specified in the SettingsRepository.
    ///
    /// - Parameters:
    /// - Parameter for: An array of TopicElement objects
    /// - Parameter checkedItems: Listed items checked by users.
    /// - Returns: A Float value representing the total score
    static func calculateTotalScore(for topic: [TopicElement], checkedItems: [String: Bool]) -> Float {
        var totalItems = 0
        for topic in topic {
            totalItems += topic.items.count
        }
        let checkItemsCount = checkedItems.count
        let result = Double(checkItemsCount) / Double(totalItems)
        return Float(result)
    }
    
    /// Sorts an array of TopicElement objects by their score and returns a subset of the specified size.
    ///
    /// This function calculates a score for each TopicElement in the input array and stores it in a dictionary.
    /// The dictionary is then filtered to remove any elements with a score of 1.0, sorted by value (score) in descending order, and a subset of the specified size is selected.
    /// The resulting dictionary is used to filter the original array of TopicElement objects, returning only the elements with keys that match the selected subset of the dictionary.
    /// - Parameters:
    ///   - with: An array of TopicElement objects to be sorted.
    ///   - using: An integer specifying the size of the subset to be returned.
    ///   - checkedItems: Listed items checked by users.
    /// - Returns: An array of TopicElement objects sorted by score and containing a subset of the specified size.
    ///
    /// - Complexity: The time complexity of this function is O(n log n), where n is the size of the input array, due to sorting the dictionary by value.
    static func sortTopicsByScore(with: [TopicElement], using: Int, checkedItems: [String: Bool]) -> [TopicElement] {
        var table = [String: Float]()
        for topicElement in with {
            table[topicElement.uid] = calculateScoreForOneTopic(for: topicElement, checkedItems: checkedItems)
        }
        table = table.filter { $0.value != 1.0 }
        let sortedDict = sortDictionaryByValue(dictionary: table, isOrderedBefore: { $0 > $1 })
        let selectUnion = sortedDict.prefix(using)
        var newDictionary = [String: Float]()
        for (key, value) in selectUnion {
            newDictionary[key] = value
        }
        return with.filter { newDictionary.keys.contains($0.uid) }
    }
    
    /// Sorts a dictionary by its values.
    ///
    /// This function takes a dictionary and returns a new dictionary where the key-value pairs are sorted by their values.
    /// The sorting is done based on a comparison function that takes two values and returns true if the first value should be ordered before the second value.
    ///
    /// - Parameters:
    ///     - dictionary: The dictionary to be sorted.
    ///     - isOrderedBefore: A function that takes two values and returns true if the first value should be ordered before the second value.
    ///
    /// Returns:
    /// A new dictionary where the key-value pairs are sorted by their values.
    static func sortDictionaryByValue<Key, Value>(dictionary: [Key: Value], isOrderedBefore: (Value, Value) -> Bool) -> [Key: Value] {
        let sortedTable = dictionary.sorted(by: { isOrderedBefore($0.value, $1.value) })
        var sortedDict: [Key: Value] = [:]
        for (key, value) in sortedTable {
            sortedDict[key] = value
        }
        return sortedDict
    }
    
}
