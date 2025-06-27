//
//  GetReports.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

import Foundation

/// # getLCBInfo
/// Gets information about reports for a specific route from LuxCrowdBack
/// - Parameters:
///   - tripId: The trip ID
///   - routeShortName: The route short name
///   - latitude: The user's current latitude
///   - longitude: The user's current longitude
///   - attribute: Optional specific attribute to filter by
///   - authToken: The authentication token for the API

public func getLCBInfo(
    tripId: String,
    routeShortName: String,
    latitude: Double,
    longitude: Double,
    attribute: ReportAttribute? = nil
) async throws -> InfoResponse {
    let baseURLString = cbURL
    
    var queryItems = [
        URLQueryItem(name: "tripId", value: tripId),
        URLQueryItem(name: "routeShortName", value: routeShortName),
        URLQueryItem(name: "location", value: "{\"lat\":\(latitude),\"long\":\(longitude)}")
    ]
    
    if let attribute = attribute {
        queryItems.append(URLQueryItem(name: "attribute", value: attribute.rawValue))
    }
        
    return try await APIClient.fetch(
        from: "/info",
        queryItems: queryItems,
        baseURL: baseURLString,
    )
}
