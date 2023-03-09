//
//  PremiumService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-16.
//

import Foundation

/// This class provides services related to premium features, such as managing subscriptions and unlocking premium content.
final class PremiumService {
    
    /// Determines whether a topic is accessible for the current user.
    ///
    /// A topic is considered accessible if it is not marked as premium, or if the user is premium.
    ///
    /// - Parameters:
    /// - topic: The TopicElement to check accessibility for.
    ///
    /// - Returns: true if the topic is accessible, false otherwise.
    static func isTopicAccessible(topic: TopicElement, isUserPremium: Bool) -> Bool {
        if isUserPremium || (!isUserPremium && !topic.isPremium) {
            return true
        }
            return false
    }
    
}
