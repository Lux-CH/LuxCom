//
//  StopTime.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTime: Codable, Sendable {
    public let place: Place
    public let mode: TransportationMode
    public let realTime: Bool
    public let headSign: String?
    public let routeShortName: String
    public let tripId: String
}
