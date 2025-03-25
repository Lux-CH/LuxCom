//
//  Leg.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct Leg: Codable {
    let mode: TransportationMode
    let from: Place
    let to: Place
    let duration: Int // in seconds
    let startTime: Date
    let endTime: Date
    let scheduledStartTime: Date
    let scheduledEndTime: Date
    let realTime: Bool
    let distance: Double?
    let headsign: String?
    let routeShortName: String?
    let intermediateStops: [Place]?
    let steps: [StepInstruction]?
}
