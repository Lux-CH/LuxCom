//
//  Place.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Place: Codable, Hashable, Sendable, Equatable, Identifiable {
    public let name: String
    public let stopId: String?
    public var id: String { stopId ?? UUID().uuidString }
    public let lat: Double
    public  let lon: Double
    public let level: Double
    public let arrival: Date?
    public let departure: Date?
    public let scheduledArrival: Date?
    public let scheduledDeparture: Date?
    public let scheduledTrack: String?
    private let _track: String?
    
    // The track is determined by the stopID (as provided by OTD)
    // Example format : odchgtfs_0000000:LEVEL:TRACK
    // Example : odchgtfs_8592679:0:F
    // F here is the track. Thus we extract this.
    // In case something bad occurs, we fallback to the original track attrib (here mapped on _track) from API.
    
    public var track: String? {
        let trackValue = stopId?.components(separatedBy: ":").last ?? _track
        return trackValue?.hasPrefix("ch_") == true ? nil : trackValue
    }
    
    let vertexType: VertexType
    
    enum VertexType: String, Codable {
        case normal = "NORMAL"
        case bikeshare = "BIKESHARE"
        case transit = "TRANSIT"
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, stopId, lat, lon, level, arrival, departure
        case scheduledArrival, scheduledDeparture, scheduledTrack
        case _track = "track"
        case vertexType
    }
}
