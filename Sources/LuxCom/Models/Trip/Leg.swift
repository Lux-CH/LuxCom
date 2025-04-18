//
//  Leg.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Leg: Codable, Sendable {
    public let mode: TransportationMode
    public let from: Place
    public let to: Place
    public let duration: Int // in seconds
    public let startTime: Date
    public let endTime: Date
    public let scheduledStartTime: Date
    public let scheduledEndTime: Date
    public let realTime: Bool
    public let distance: Double?
    public let headsign: String?
    public let routeShortName: String?
    public let intermediateStops: [Place]?
    public let steps: [StepInstruction]?
}
