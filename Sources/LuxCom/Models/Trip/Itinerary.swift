//
//  Itinerary.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Itinerary: Codable, Sendable, Equatable {
    public let duration: Int
    public let startTime: Date
    public let endTime: Date
    public let transfers: Int
    public let legs: [Leg]
    
    // prob not the best way but uhm
    public static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
        return lhs.startTime == rhs.startTime &&
        lhs.endTime == rhs.endTime &&
        lhs.duration == rhs.duration &&
        lhs.transfers == rhs.transfers &&
        lhs.legs.count == rhs.legs.count
    }
}
