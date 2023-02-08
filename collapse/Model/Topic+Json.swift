//
//  Topic+Json.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import Foundation

// MARK: - TopicElement
struct TopicElement: Decodable {
    
    let uid, title, subtitle, image: String
    let descriptionShort, descriptionLong: String
    let items: [Item]
    let isPremium: Bool
}

// MARK: - Item
struct Item: Decodable {
    
    let title: String
    let isChecked: Bool
    let subtitle, image, description, mode: String
}
