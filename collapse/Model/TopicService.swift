//
//  TopicService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-03-08.
//

import Foundation

/// Topic service is the manager of topic and Items ( filtering, etc...) 
class TopicService {
    
    /// Loads and filters items for a given topic, suitable for display in a table view.
    ///
    ///
    /// Items are filtered based on the user's preferred mode, as well as the item's mode.
    /// Regular items are always included, while intermediate items are included if the user is in intermediate or advanced mode.
    /// Advanced items are only included if the user is in advanced mode.
    ///
    /// - Parameters:
    /// - with: The TopicElement to load items for.
    ///
    /// - Returns: A 2D array of Item objects, sorted by mode and title.
    ///
    static func loadFilteredItemsForTableView(with: TopicElement) -> [[Item]] {
        var filteredItems = [[Item]]()
        let userMode = SettingsRepository.mode
        let regularItems = with.items.filter { $0.mode == Mode.essential.jsonReferenceName }.sorted { $0.title < $1.title }
        let intermediateItems = with.items.filter { $0.mode == Mode.intermediate.jsonReferenceName }.sorted { $0.title < $1.title }
        let advancedItems = with.items.filter { $0.mode == Mode.advanced.jsonReferenceName }.sorted { $0.title < $1.title }
        
        if !regularItems.isEmpty {
            filteredItems.append(regularItems)
        }
        if !intermediateItems.isEmpty && (userMode == Mode.advanced.jsonReferenceName || userMode == Mode.intermediate.jsonReferenceName ) {
            filteredItems.append(intermediateItems)
        }
        if !advancedItems.isEmpty && SettingsRepository.mode == Mode.advanced.jsonReferenceName {
            filteredItems.append(advancedItems)
        }
        return filteredItems
    }
}
