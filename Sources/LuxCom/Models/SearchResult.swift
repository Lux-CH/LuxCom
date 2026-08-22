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
    public var modes: [TransportationMode] = []
    public var groupedStopIds: [String] = []
    public var hasRailNeighbour: Bool?

    public var servesRail: Bool { modes.contains { $0.isRail } }

    public var servesMainlineRail: Bool { modes.contains { $0.isMainlineRail } }

    public enum CodingKeys: String, CodingKey {
        case type, tokens, name, id, lat, lon, level, street, houseNumber, zip, areas, score, modes
        case groupedStopIds, hasRailNeighbour
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(LocationType.self, forKey: .type)
        tokens = try container.decode([[Int]].self, forKey: .tokens)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        level = try container.decodeIfPresent(Double.self, forKey: .level)
        street = try container.decodeIfPresent(String.self, forKey: .street)
        houseNumber = try container.decodeIfPresent(String.self, forKey: .houseNumber)
        zip = try container.decodeIfPresent(String.self, forKey: .zip)
        areas = try container.decodeIfPresent([Area].self, forKey: .areas) ?? []
        score = try container.decode(Double.self, forKey: .score)
        modes = try container.decodeIfPresent([TransportationMode].self, forKey: .modes) ?? []
        groupedStopIds = try container.decodeIfPresent([String].self, forKey: .groupedStopIds) ?? []
        hasRailNeighbour = try container.decodeIfPresent(Bool.self, forKey: .hasRailNeighbour)
    }

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
        score: Double,
        modes: [TransportationMode] = [],
        groupedStopIds: [String] = [],
        hasRailNeighbour: Bool? = nil
    ) {
        self.modes = modes
        self.groupedStopIds = groupedStopIds
        self.hasRailNeighbour = hasRailNeighbour
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
