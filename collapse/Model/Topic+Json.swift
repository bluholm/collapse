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
    let links: [Link]
    let isPremium: Bool
}

// MARK: - Item
struct Item: Decodable {
    
    let id: String
    let links: [Link]
    let title: String
    let content: [Content]
    let subtitle, image, mode: String
}

// MARK: - Link
struct Link: Codable, Hashable {
    
    let url: String
    let title: String
    let description: String
}

struct Content: Codable {
    
    let type: String
    let value: String
}
