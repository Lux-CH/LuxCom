//
//  Place.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Place: Codable, Hashable, Sendable, Equatable, Identifiable {
    public var name: String
    public let stopId: String?
    public let parentId: String?
    public var id: String { stopId ?? UUID().uuidString }
    public let lat: Double
    public let lon: Double
    public let level: Double
    public let arrival: Date?
    public let departure: Date?
    public let scheduledArrival: Date?
    public let scheduledDeparture: Date?
    public let scheduledTrack: String?
    public let track: String?
    
    public let vertexType: VertexType
    public var modes: [TransportationMode]
    public let importance: Double?

    public enum VertexType: String, Codable, Sendable {
        case normal = "NORMAL"
        case bikeshare = "BIKESHARE"
        case transit = "TRANSIT"
    }

    public enum CodingKeys: String, CodingKey {
        case name, stopId, parentId, lat, lon, level, arrival, departure
        case scheduledArrival, scheduledDeparture, scheduledTrack
        case track = "track"
        case vertexType, modes, importance
    }
    public init(name: String, stopId: String?, parentId: String? = nil, lat: Double, lon: Double, level: Double, arrival: Date?, departure: Date?, scheduledArrival: Date?, scheduledDeparture: Date?, scheduledTrack: String?, track: String?, vertexType: VertexType, modes: [TransportationMode] = [], importance: Double? = nil) {
        self.name = name
        self.stopId = stopId
        self.parentId = parentId
        self.lat = lat
        self.lon = lon
        self.level = level
        self.arrival = arrival
        self.departure = departure
        self.scheduledArrival = scheduledArrival
        self.scheduledDeparture = scheduledDeparture
        self.scheduledTrack = scheduledTrack
        self.track = track
        self.vertexType = vertexType
        self.modes = modes
        self.importance = importance
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        stopId = try container.decodeIfPresent(String.self, forKey: .stopId)
        parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        level = try container.decodeIfPresent(Double.self, forKey: .level) ?? 0
        arrival = try container.decodeIfPresent(Date.self, forKey: .arrival)
        departure = try container.decodeIfPresent(Date.self, forKey: .departure)
        scheduledArrival = try container.decodeIfPresent(Date.self, forKey: .scheduledArrival)
        scheduledDeparture = try container.decodeIfPresent(Date.self, forKey: .scheduledDeparture)
        scheduledTrack = try container.decodeIfPresent(String.self, forKey: .scheduledTrack)
        track = try container.decodeIfPresent(String.self, forKey: .track)
        vertexType = try container.decode(VertexType.self, forKey: .vertexType)
        modes = try container.decodeIfPresent([TransportationMode].self, forKey: .modes) ?? []
        importance = try container.decodeIfPresent(Double.self, forKey: .importance)
    }
}
