//
//  SearchResult.swift
//  LuxCom
//
//  Created by Constantin Clerc on 24.03.2025.
//

import Foundation

public struct SearchResult: Codable, Identifiable, Sendable {
    public let type: LocationType
    public let tokens: [[Int]]
    public let name: String
    public let id: String
    public let lat: Double
    public let lon: Double
    public let level: Double?
    public let street: String?
    public let houseNumber: String?
    public let zip: String?
    public let areas: [Area]
    public let score: Double
    
    public struct Area: Codable, Sendable {
        public let name: String
        public let adminLevel: Int
        public let matched: Bool
        public let `default`: Bool?
        
        public enum CodingKeys: String, CodingKey {
            case name
            case adminLevel
            case matched
            case `default` = "default"
        }
    }
}
