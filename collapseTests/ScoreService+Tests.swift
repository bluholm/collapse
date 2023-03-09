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
    
}
