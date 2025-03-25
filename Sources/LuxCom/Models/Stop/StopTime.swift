//
//  StopTime.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTime: Codable {
    let place: Place
    let mode: TransportationMode
    let realTime: Bool
    let headSign: String?
    let routeShortName: String
    let tripId: String
}
