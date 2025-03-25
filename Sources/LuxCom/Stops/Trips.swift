//
//  Trips.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

func getTrip(tripId: String) async throws -> Itinerary {
    let queryItems = [URLQueryItem(name: "tripId", value: tripId)]
    return try await APIClient.fetch(from: "/trip", queryItems: queryItems)
}
