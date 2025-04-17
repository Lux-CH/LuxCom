//
//  Geocode.swift
//  LuxCom
//
//  Created by Constantin Clerc on 24.03.2025.
//

import Foundation

public func geocode(text: String, language: String = "fr", type: LocationType? = nil, place: (Double, Double)? = nil, placeBias: Int? = nil) async throws -> [SearchResult] {
    var queryItems = [
        URLQueryItem(name: "text", value: text),
        URLQueryItem(name: "language", value: language)
    ]
    
    if let locType = type {
        queryItems.append(URLQueryItem(name: "type", value: locType.rawValue))
    }
    
    if let specifiedPlace = place {
        queryItems.append(URLQueryItem(name: "place", value: "\(specifiedPlace.0), \(specifiedPlace.1)"))
    }
    
    if let specifiedPlaceBias = placeBias {
        queryItems.append(URLQueryItem(name: "placeBias", value: String(specifiedPlaceBias)))
    }
    
    return try await APIClient.fetch(from: "/geocode", queryItems: queryItems)
}
