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
    public let legGeometry: LegGeometry
    public let agencyId: String?
    public let tripId: String?
    public let steps: [StepInstruction]?
    public let interlineWithPreviousLeg: Bool?
    public let alternatives: [[Leg]]?
    public init(mode: TransportationMode, from: Place, to: Place, duration: Int, startTime: Date, endTime: Date, scheduledStartTime: Date, scheduledEndTime: Date, realTime: Bool, distance: Double?, headsign: String?, routeShortName: String?, intermediateStops: [Place]?, legGeometry: LegGeometry, agencyId: String?, tripId: String?, steps: [StepInstruction]?, interlineWithPreviousLeg: Bool? = nil, alternatives: [[Leg]]? = nil) {
        self.mode = mode
        self.from = from
        self.to = to
        self.duration = duration
        self.startTime = startTime
        self.endTime = endTime
        self.scheduledStartTime = scheduledStartTime
        self.scheduledEndTime = scheduledEndTime
        self.realTime = realTime
        self.distance = distance
        self.headsign = headsign
        self.routeShortName = routeShortName
        self.intermediateStops = intermediateStops
        self.legGeometry = legGeometry
        self.agencyId = agencyId
        self.tripId = tripId
        self.steps = steps
        self.interlineWithPreviousLeg = interlineWithPreviousLeg
        self.alternatives = alternatives
    }
}
