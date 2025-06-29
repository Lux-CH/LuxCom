//
//  Stops.swift
//  LuxCom
//
//  Created by Constantin Clerc on 29.06.2025.
//

import Foundation

public func getMapStops(min: (Double, Double), max: (Double, Double)) async throws -> [Place] {
    let queryItems = [URLQueryItem(name: "min", value: "\(min.0), \(min.1)"), URLQueryItem(name: "max", value: "\(max.0), \(max.1)")]
    return try await APIClient.fetch(from: "/map/stops", queryItems: queryItems)
}

