//
//  Trip.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Trip: Codable, Sendable {
    public let from: Place
    public let to: Place
    public let direct: [Itinerary]
    public let itineraries: [Itinerary]
    public let previousPageCursor: String
    public let nextPageCursor: String
}
