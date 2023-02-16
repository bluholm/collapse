//
//  PremiumService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-16.
//

import Foundation

final class PremiumService {
    
    static func isTopicAccessible(topic: TopicElement) -> Bool {
        if !topic.isPremium || ( SettingsRepository.userIsPremium && topic.isPremium) {
            return true
        }
        return false
    }
    
    static func loadFilteredItemsForTableView(with: TopicElement) -> [[Item]] {
        var filteredItems = [[Item]]()
        let regularItems = with.items.filter { $0.mode == Mode.essential.jsonReferenceName }.sorted { $0.title < $1.title }
        let intermediateItems = with.items.filter { $0.mode == Mode.intermediate.jsonReferenceName }.sorted { $0.title < $1.title }
        let advancedItems = with.items.filter { $0.mode == Mode.advanced.jsonReferenceName }.sorted { $0.title < $1.title }
        
        if !regularItems.isEmpty {
            filteredItems.append(regularItems)
        }
        if !intermediateItems.isEmpty && (SettingsRepository.mode == Mode.advanced.jsonReferenceName || SettingsRepository.mode == Mode.intermediate.jsonReferenceName ) {
            filteredItems.append(intermediateItems)
        }
        if !advancedItems.isEmpty && SettingsRepository.mode == Mode.advanced.jsonReferenceName {
            filteredItems.append(advancedItems)
        }
        return filteredItems
    }
}
