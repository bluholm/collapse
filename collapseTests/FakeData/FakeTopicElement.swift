// swiftlint:disable:next
//  FakeTopicElement.swift
//  collapseTests
//
//  Created by Marc-Antoine BAR on 2023-03-08.
//

import Foundation
@testable import collapse

class FakeTopicElement {
    
    static let item1 = Item(id: "AAA", title: "Item 1", content: [], mode: "essential")
    static let item2 = Item(id: "AAB", title: "Item 2", content: [], mode: "intermediate")
    static let item3 = Item(id: "AAC", title: "Item 3", content: [], mode: "advanced")
    static let topic0 = TopicElement(uid: "topic0",
                             title: "Topic 0",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [item1, item2, item3],
                             links: [],
                             isPremium: false)
    static let topic1 = TopicElement(uid: "topic1",
                             title: "Topic 1",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [],
                             links: [],
                             isPremium: false)
    static let topic2 = TopicElement(uid: "topic2",
                             title: "Topic 2",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [],
                             links: [],
                             isPremium: true)
    static let topic3 = TopicElement(uid: "topic3",
                             title: "Topic 3",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [],
                             links: [],
                             isPremium: false)
    static let topic4 = TopicElement(uid: "topic1",
                             title: "Topic 1",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [],
                             links: [],
                             isPremium: true)
    static let topic5 = TopicElement(uid: "topic4",
                             title: "Topic 4",
                             subtitle: "",
                             image: "",
                             descriptionShort: "",
                             descriptionLong: "",
                             items: [],
                             links: [],
                             isPremium: false)
}
