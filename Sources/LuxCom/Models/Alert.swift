//
//  Alert.swift
//  LuxCom
//
//  Created by Constantin Clerc on 18.08.2025.
//

import Foundation

public struct Alert: Codable, Hashable, Sendable {
    public let headerText: String
    public let descriptionText: String
    public let cause: Cause?
    public let causeDetail: String?
    public let effect: AlertEffect?
    public let effectDetail: String?
    public let communicationPeriod: [TimeRange]?
    public let impactPeriod: [TimeRange]?
    
    public enum Cause: String, Codable, Sendable {
        case unknown = "UNKNOWN_CAUSE"
        case other = "OTHER_CAUSE"
        case technical = "TECHNICAL_PROBLEM"
        case strike = "STRIKE"
        case demo = "DEMONSTRATION"
        case accident = "ACCIDENT"
        case holiday = "HOLIDAY"
        case weather = "WEATHER"
        case maintenance = "MAINTENANCE"
        case construction = "CONSTRUCTION"
        case police = "POLICE_ACTIVITY"
        case medical = "MEDICAL_EMERGENCY"
    }
    
    public enum AlertEffect: String, Codable, Sendable {
        case noService = "NO_SERVICE"
        case reducedService = "REDUCED_SERVICE"
        case significantDelays = "SIGNIFICANT_DELAYS"
        case detour = "DETOUR"
        case additionalService = "ADDITIONAL_SERVICE"
        case modifiedService = "MODIFIED_SERVICE"
        case other = "OTHER_EFFECT"
        case unknown = "UNKNOWN_EFFECT"
        case stopMoved = "STOP_MOVED"
        case noEffect = "NO_EFFECT"
        case accessibilityIssue = "ACCESSIBILITY_ISSUE"
    }
}

public struct TimeRange: Codable, Hashable, Sendable {
    public let start: Date?
    public let end: Date?
}
