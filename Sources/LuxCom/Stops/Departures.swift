//
//  Departures.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public func getDeparturesForStop(
    stopId: String,
    time: Date = Date(),
    arriveBy: Bool = false,
    direction: String? = nil,
    mode: [String]? = ["TRANSIT"],
    numberOfEvents: Int,
    radius: Int? = nil,
    pageCursor: String? = nil
) async throws -> StopTimes {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    
    var queryItems = [
        URLQueryItem(name: "stopId", value: stopId),
        URLQueryItem(name: "time", value: dateFormatter.string(from: time)),
        URLQueryItem(name: "arriveBy", value: String(arriveBy)),
        URLQueryItem(name: "n", value: String(numberOfEvents))
    ]
    
    if let direction = direction {
        queryItems.append(URLQueryItem(name: "direction", value: direction))
    }
    
    if let modes = mode {
        queryItems.append(contentsOf: modes.map { URLQueryItem(name: "mode", value: $0) })
    }
    
    if let radius = radius {
        queryItems.append(URLQueryItem(name: "exactRadius", value: "false"))
        queryItems.append(URLQueryItem(name: "radius", value: String(radius)))
    }
    
    if let pageCursor = pageCursor {
        queryItems.append(URLQueryItem(name: "pageCursor", value: pageCursor))
    }
        
    return try await APIClient.fetch(from: "/stoptimes", apiVersion: "v4", queryItems: queryItems)
}
