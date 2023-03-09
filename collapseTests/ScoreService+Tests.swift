//
//  ScoreServiceTests.swift
//  collapseTests
//
//  Created by Marc-Antoine BAR on 2023-03-06.
//

import XCTest
@testable import collapse

final class ScoreServiceTests: XCTestCase {
    
    let service = ScoreService()
    
    func testCalculateScoreForOneTopic() {
        // Given
        var checkedItemMock: [String: Bool] = [:]
        
        checkedItemMock["AAA"] = true
        // Then
        let result = ScoreService.calculateScoreForOneTopic(for: FakeTopicElement.topic0, checkedItems: checkedItemMock)
        
        XCTAssertEqual(result, 0.33333334)
    }
    
    func testSortTopicElementsByIsPremium() {
           // Given
        let topicElements = [FakeTopicElement.topic1,
                             FakeTopicElement.topic2,
                             FakeTopicElement.topic3,
                             FakeTopicElement.topic4,
                             FakeTopicElement.topic5]
           
           // When
           let sortedElements = ScoreService.sortTopicElementsByIsPremium(topicElements)
           
           // Then
        XCTAssertEqual(sortedElements, [FakeTopicElement.topic1,
                                        FakeTopicElement.topic3,
                                        FakeTopicElement.topic5,
                                        FakeTopicElement.topic2,
                                        FakeTopicElement.topic4])
       }
    
    func testIsTopicAccessible() {
        // Given
        let freeTopic = FakeTopicElement.topic0
        let premiumTopic = FakeTopicElement.topic2
        
        // Then
        XCTAssertTrue(PremiumService.isTopicAccessible(topic: freeTopic, isUserPremium: false), "Free topic should be accessible to everyone")
        XCTAssertFalse(PremiumService.isTopicAccessible(topic: premiumTopic, isUserPremium: false), "Premium topic should not be accessible to non-premium user")
        XCTAssertTrue(PremiumService.isTopicAccessible(topic: premiumTopic, isUserPremium: true), "Premium topic should be accessible to premium user")
    }
    
}
