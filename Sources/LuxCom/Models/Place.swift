//
//  Place.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Place: Codable {
    let name: String
    let stopId: String?
    let lat: Double
    let lon: Double
    let level: Int
    let arrival: Date?
    let departure: Date?
    let scheduledArrival: Date?
    let scheduledDeparture: Date?
    let scheduledTrack: String?
    private let _track: String?
    
    // The track is determined by the stopID (as provided by OTD)
    // Example format : odchgtfs_0000000:LEVEL:TRACK
    // Example : odchgtfs_8592679:0:F
    // F here is the track. Thus we extract this.
    // In case something bad occurs, we fallback to the original track attrib (here mapped on _track) from API.
    
    var track: String? {
        stopId?.components(separatedBy: ":").last ?? _track
    }
    
    let vertexType: VertexType
    
    enum VertexType: String, Codable {
        case normal = "NORMAL"
        case bikeshare = "BIKESHARE"
        case transit = "TRANSIT"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, stopId, lat, lon, level, arrival, departure
        case scheduledArrival, scheduledDeparture, scheduledTrack
        case _track = "track"
        case vertexType
    }
}
