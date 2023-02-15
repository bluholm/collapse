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
}
