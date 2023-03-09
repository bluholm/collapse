//
//  Topic+Json.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import Foundation

// MARK: - TopicElement
struct TopicElement: Decodable, Equatable {
    
    /// uid: a unique identifier for the topic
    let uid: String
    
    /// title: the title of the topic
    let title: String
    
    /// subtitle: a subtitle for the topic
    let subtitle: String
    
    /// image: the URL of an image for the topic
    let image: String
    
    /// descriptionShort: a short description of the topic (200 words )
    let descriptionShort: String
    
    /// descriptionLong: a longer description of the topic (500 words and more)
    let descriptionLong: String
    
    /// items: an array of Item objects that represent the subtopics or items within the topic
    let items: [Item]
    
    /// links: an array of Link objects that represent links related to the topic
    let links: [Link]

    static func == (lhs: TopicElement, rhs: TopicElement) -> Bool {
                return lhs.uid == rhs.uid &&
                    lhs.title == rhs.title &&
                    lhs.subtitle == rhs.subtitle &&
                    lhs.image == rhs.image &&
                    lhs.descriptionShort == rhs.descriptionShort &&
                    lhs.descriptionLong == rhs.descriptionLong &&
                    lhs.items == rhs.items &&
                    lhs.links == rhs.links
    }
}

// MARK: - Item
/// Item is a Swift struct that conforms to the Decodable protocol.
struct Item: Decodable, Equatable {
    
    /// String representing the unique identifier of the item 3 letters ,
    ///
    /// all uniQue ( ex: AAA, AAB, AAC ...)
    ///
    let id: String
    
    /// String representing the title of the item
    let title: String
    
    /// content: an array of Content structs, representing the contents of the item
    let content: [Content]
    
    /// String representing the mode of the item mode has to bee :
    ///
    /// The mode HAVE to be one of these words :
    ///  - `essential`,
    ///  - `intermediate`
    ///  - `advanced`
    let mode: String
    
    static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id &&
                lhs.title == rhs.title &&
                lhs.content == rhs.content &&
                lhs.mode == rhs.mode
        }
}

// MARK: - Link
/// Link is a Swift struct that conforms to both the Codable and Hashable protocols.
struct Link: Codable, Hashable {
    
    /// url: a String representing the URL of the link
    let url: String
    
    /// title: a String representing the title of the link
    let title: String
    
    /// description: a String representing the description of the link
    let description: String
    
}

// MARK: - Content
/// Content is a Swift struct that conforms to the Codable protocol. It has two properties:
struct Content: Codable, Equatable {
    
    /// type: a String representing the type of content (e.g., "text", "image", "video", etc.)
    let type: String
    
    /// value: a String representing the actual content (e.g., the text string, image URL, video URL, etc.)
    let value: String
    
}
