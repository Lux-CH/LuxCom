//
//  TripPlanner.swift
//  LuxCom
//
//  Created by Constantin Clerc on 06.02.2025.
//

import Foundation
import OJP

func findTrip(ojpConfig: OJP, from: OJPv2.PlaceRefChoice, via: [OJPv2.PlaceRefChoice]? = nil, to: OJPv2.PlaceRefChoice) async throws -> OJPv2.TripDelivery {
    if let viaDest = via {
        return try await ojpConfig.requestTrips(from: from, to: to, via: viaDest, params: .init())
    }
    return try await ojpConfig.requestTrips(from: from, to: to, params: .init())
}
