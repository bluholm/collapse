//
//  collapseTests.swift
//  collapseTests
//
//  Created by Marc-Antoine BAR on 2023-02-09.
//

import XCTest
@testable import collapse

final class CollapseTests: XCTestCase {
    
    let modes = ["essential", "intermediate", "advanced"]
    
    func loadFiles(langage: String) -> [TopicElement] {
        var topicList = [TopicElement]()
        JsonService.parse(file: langage) { result in
            switch result {
            case .success(let table):
                topicList =  table
            case .failure(let error):
                print(error)
            }
        }
        return topicList
    }
    
    func testIfModeIsCorrectInFrenchFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "french")
        for topic in topicList {
            for item in topic.items where !modes.contains(item.mode) {
                XCTFail("fail because mode is not correct at item : \(item.id) ; \(item.title) ; mode is= \(item.mode)")
            }
        }
    }
    func testIfModeIsCorrectInEnglishFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "english")
        for topic in topicList {
            for item in topic.items where !modes.contains(item.mode) {
                XCTFail("fail because mode is not correct at item : \(item.id) ; \(item.title) ; mode is= \(item.mode)")
            }
        }
    }
    
    func testIfTitleOrSubtitleISEmptyInFrenchFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "french")
        for topic in topicList {
            if topic.title.count <= 3 || topic.subtitle.count <= 3 {
                XCTFail("fail because size title")
            }
        }
    }
    
    func testIfTitleOrSubtitleISEmptyInEnglishFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "english")
        for topic in topicList {
            if topic.title.count <= 3 || topic.subtitle.count <= 3 {
                XCTFail("fail because size title")
            }
        }
    }
    
    func testIfItemsTitleOrSubtitleISEmptyInFrenchFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "french")
        for topic in topicList {
            for item in topic.items where item.title.count <= 3 {
                XCTFail("fail because size title at \(item.id)")
            }
        }
    }
    
    func testIfItemsTitleOrSubtitleISEmptyInEnglishFiles() {
        var topicList = [TopicElement]()
        topicList = loadFiles(langage: "english")
        for topic in topicList {
            for item in topic.items where item.title.count <= 3 {
                XCTFail("fail because size title")
            }
        }
    }
    
    func testIfNotSameIdInTopicInFrenchFiles() {
        var topicList = [TopicElement]()
        var idTopicList = [String]()
        topicList = loadFiles(langage: "french")
        for topic in topicList {
            idTopicList.append(topic.uid)
        }
        
        XCTAssertEqual(idTopicList.count, Set(idTopicList).count)
    }
    
    func testIfNotSameIdInTopicInEnglishFiles() {
        var topicList = [TopicElement]()
        var idTopicList = [String]()
        topicList = loadFiles(langage: "english")
        for topic in topicList {
            idTopicList.append(topic.uid)
        }
        
        XCTAssertEqual(idTopicList.count, Set(idTopicList).count)
    }
    
    func testIfNotSameIdInItemInFrenchFiles() {
        var topicList = [TopicElement]()
        var idItemList = [String]()
        topicList = loadFiles(langage: "french")
        for topic in topicList {
            for item in topic.items {
                idItemList.append(item.id)
            }
        }
        
        XCTAssertEqual(idItemList.count, Set(idItemList).count)
    }
    
    func testIfNotSameIdInItemInEnglishFiles() {
        var topicList = [TopicElement]()
        var idItemList = [String]()
        topicList = loadFiles(langage: "english")
        for topic in topicList {
            for item in topic.items {
                idItemList.append(item.id)
            }
        }
        
        XCTAssertEqual(idItemList.count, Set(idItemList).count)
    }
    
}
