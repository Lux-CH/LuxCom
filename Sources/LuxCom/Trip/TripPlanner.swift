//
//  TripPlanner.swift
//  LuxCom
//
//  Created by Constantin Clerc on 06.02.2025.
//

import Foundation
import OJP

public func findTrip(ojpConfig: OJP, from: OJPv2.PlaceRefChoice, via: [OJPv2.PlaceRefChoice]? = nil, to: OJPv2.PlaceRefChoice) async throws -> OJPv2.TripDelivery {
    if let viaDest = via {
        return try await ojpConfig.requestTrips(from: from, to: to, via: viaDest, params: .init())
    }
    return try await ojpConfig.requestTrips(from: from, to: to, params: .init())
}
// MARK: idk if i should add a share trip feature, might be intersting ngl..
// i'll have to figure out TripInfoDel vs TripDel, might be able to get tripdel through TripInfoDel
//public func requestTrip(ojpConfig: OJP, ref: String, operatingDay: String) async throws -> OJPv2.TripInfoDelivery {
//    return try await ojpConfig.requestTripInfo(journeyRef: ref, operatingDayRef: operatingDay)
//}
