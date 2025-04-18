//
//  Itinerary.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Itinerary: Codable, Sendable {
    public let duration: Int
    public let startTime: Date
    public let endTime: Date
    public let transfers: Int
    public let legs: [Leg]
}
