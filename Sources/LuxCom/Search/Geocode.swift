//
//  Geocode.swift
//  LuxCom
//
//  Created by Constantin Clerc on 24.03.2025.
//

import Foundation

public func geocode(text: String, language: String = "fr", type: LocationType? = nil) async throws -> [SearchResult] {
    var queryItems = [
        URLQueryItem(name: "text", value: text),
        URLQueryItem(name: "language", value: language)
    ]
    
    if let locType = type {
        queryItems.append(URLQueryItem(name: "type", value: locType.rawValue))
    }
    
    return try await APIClient.fetch(from: "/geocode", queryItems: queryItems)
}
