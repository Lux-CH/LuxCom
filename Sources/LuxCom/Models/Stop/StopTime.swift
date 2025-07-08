//
//  StopTime.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTime: Codable, Sendable, Identifiable, Hashable {
    public var id: String { tripId }
    public let place: Place
    public let mode: TransportationMode
    public let realTime: Bool
    public let headsign: String?
    public let routeShortName: String
    public let tripId: String
    public let agencyId: String
    public let cancelled: Bool
    public init(place: Place, mode: TransportationMode, realTime: Bool, headsign: String?, routeShortName: String, tripId: String, agencyId: String, cancelled: Bool) {
        self.place = place
        self.mode = mode
        self.realTime = realTime
        self.headsign = headsign
        self.routeShortName = routeShortName
        self.tripId = tripId
        self.agencyId = agencyId
        self.cancelled = cancelled
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(tripId)
    }
    
    public static func == (lhs: StopTime, rhs: StopTime) -> Bool {
        return lhs.tripId == rhs.tripId
    }
}
