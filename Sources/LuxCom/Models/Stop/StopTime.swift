//
//  StopTime.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTime: Codable, Sendable, Identifiable {
    public var id: String { tripId }
    public let place: Place
    public let mode: TransportationMode
    public let realTime: Bool
    public let headsign: String?
    public let routeShortName: String
    public let tripId: String
}
