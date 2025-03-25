//
//  Itinerary.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Itinerary: Codable {
    let duration: Int
    let startTime: Date
    let endTime: Date
    let transfers: Int
    let legs: [Leg]
}
