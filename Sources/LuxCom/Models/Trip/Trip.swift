//
//  Trip.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Trip: Codable {
    let from: Place
    let to: Place
    let direct: [Itinerary]
    let itineraries: [Itinerary]
    let previousPageCursor: String
    let nextPageCursor: String
}
