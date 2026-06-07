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
    
    public enum VertexType: String, Codable, Sendable {
        case normal = "NORMAL"
        case bikeshare = "BIKESHARE"
        case transit = "TRANSIT"
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, stopId, parentId, lat, lon, level, arrival, departure
        case scheduledArrival, scheduledDeparture, scheduledTrack
        case track = "track"
        case vertexType
    }
    public init(name: String, stopId: String?, parentId: String? = nil, lat: Double, lon: Double, level: Double, arrival: Date?, departure: Date?, scheduledArrival: Date?, scheduledDeparture: Date?, scheduledTrack: String?, track: String?, vertexType: VertexType) {
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
    }
}
