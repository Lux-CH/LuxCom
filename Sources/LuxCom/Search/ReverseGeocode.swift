//
//  ReverseGeocode.swift
//  LuxCom
//
//  Created by Constantin Clerc on 24.03.2025.
//

import Foundation

public func reverseGeocode(place: (Double, Double), type: LocationType? = nil) async throws -> [SearchResult] {
    var queryItems = [
        URLQueryItem(name: "place", value: "\(place.0), \(place.1)")
    ]
    
    if let locType = type {
        queryItems.append(URLQueryItem(name: "type", value: locType.rawValue))
    }
    
    return try await APIClient.fetch(from: "/reverse-geocode", queryItems: queryItems)
}
