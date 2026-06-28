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
        public init(name: String, adminLevel: Int, matched: Bool, `default`: Bool?) {
            self.name = name
            self.adminLevel = adminLevel
            self.matched = matched
            self.`default` = `default`
        }
    }
    
    // Explicit initializer
    public init(
        type: LocationType,
        tokens: [[Int]],
        name: String,
        id: String,
        lat: Double,
        lon: Double,
        level: Double? = nil,
        street: String? = nil,
        houseNumber: String? = nil,
        zip: String? = nil,
        areas: [Area],
        score: Double
    ) {
        self.type = type
        self.tokens = tokens
        self.name = name
        self.id = id
        self.lat = lat
        self.lon = lon
        self.level = level
        self.street = street
        self.houseNumber = houseNumber
        self.zip = zip
        self.areas = areas
        self.score = score
    }
}
