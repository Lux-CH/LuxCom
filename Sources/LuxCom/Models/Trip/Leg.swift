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
    public let cancelled: Bool
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

    public enum CodingKeys: String, CodingKey {
        case mode, from, to, duration, startTime, endTime
        case scheduledStartTime, scheduledEndTime, realTime, cancelled
        case distance, headsign, routeShortName, intermediateStops
        case legGeometry, agencyId, tripId, steps, interlineWithPreviousLeg, alternatives
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mode = try container.decode(TransportationMode.self, forKey: .mode)
        from = try container.decode(Place.self, forKey: .from)
        to = try container.decode(Place.self, forKey: .to)
        duration = try container.decode(Int.self, forKey: .duration)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decode(Date.self, forKey: .endTime)
        scheduledStartTime = try container.decode(Date.self, forKey: .scheduledStartTime)
        scheduledEndTime = try container.decode(Date.self, forKey: .scheduledEndTime)
        realTime = try container.decode(Bool.self, forKey: .realTime)
        cancelled = try container.decodeIfPresent(Bool.self, forKey: .cancelled) ?? false
        distance = try container.decodeIfPresent(Double.self, forKey: .distance)
        headsign = try container.decodeIfPresent(String.self, forKey: .headsign)
        routeShortName = try container.decodeIfPresent(String.self, forKey: .routeShortName)
        intermediateStops = try container.decodeIfPresent([Place].self, forKey: .intermediateStops)
        legGeometry = try container.decode(LegGeometry.self, forKey: .legGeometry)
        agencyId = try container.decodeIfPresent(String.self, forKey: .agencyId)
        tripId = try container.decodeIfPresent(String.self, forKey: .tripId)
        steps = try container.decodeIfPresent([StepInstruction].self, forKey: .steps)
        interlineWithPreviousLeg = try container.decodeIfPresent(Bool.self, forKey: .interlineWithPreviousLeg)
        alternatives = try container.decodeIfPresent([[Leg]].self, forKey: .alternatives)
    }

    public init(mode: TransportationMode, from: Place, to: Place, duration: Int, startTime: Date, endTime: Date, scheduledStartTime: Date, scheduledEndTime: Date, realTime: Bool, cancelled: Bool = false, distance: Double?, headsign: String?, routeShortName: String?, intermediateStops: [Place]?, legGeometry: LegGeometry, agencyId: String?, tripId: String?, steps: [StepInstruction]?, interlineWithPreviousLeg: Bool? = nil, alternatives: [[Leg]]? = nil) {
        self.mode = mode
        self.from = from
        self.to = to
        self.duration = duration
        self.startTime = startTime
        self.endTime = endTime
        self.scheduledStartTime = scheduledStartTime
        self.scheduledEndTime = scheduledEndTime
        self.realTime = realTime
        self.cancelled = cancelled
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
