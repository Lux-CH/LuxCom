//
//  RouteOptions.swift
//  LuxCom
//
//  Created by Constantin Clerc on 20.03.2025.
//
/// - Parameters:
///   - from: A coordinates tuple `(latitude, longitude)` representing the starting location.
///   - to: A coordinates tuple `(latitude, longitude)` representing the destination location.
///   - via: Via different stops
///   - viaMinimumStay: An array of minimum stay durations (in minutes) at each waypoint.
///   - time: The reference date/time for route calculation. Defaults to the current date/time.
///   - arriveBy: A Boolean indicating whether the route should arrive by the specified time (`true`) or depart at the specified time (`false`). Defaults to `false`.
///   - maxTransfers: The maximum number of allowed transfers during the trip.
///   - minTransferTime: The minimum transfer time (in seconds) required between connections.
///   - pedestrianProfile: The pedestrian profile for walking segments (walking/wheelchair).
///   - useRoutedTransfers: A Boolean indicating whether to use precomputed transfer routes from OSM. Defaults to `false`.
///   - detailedTransfers: A Boolean indicating whether to include transfer polylines and step-by-step instructions. Defaults to `true`.
///   - transitModes: An optional array of allowed transportation modes (e.g., bus, subway, tram).
///   - numItineraries: An optional number specifying the maximum number of route options to return.
///   - pageCursor: An optional string for paginating results.
///   - timetableView: Defaults to `true`.
///   - maxPreTransitTime: The maximum allowed time (in seconds) before boarding the first transit vehicle.
///   - maxPostTransitTime: The maximum allowed time (in seconds) after leaving the last transit vehicle.

import Foundation

public struct RouteOptions: Sendable {
    public let from: (Double, Double)
    public let to: (Double, Double)
    public let via: [String]?
    public let viaMinimumStay: [Int]
    public let time: Date?
    public let arriveBy: Bool
    public let maxTransfers: Int
    public let minTransferTime: Int
    public let pedestrianProfile: PedestrianProfile
    public let useRoutedTransfers: Bool? = false
    public let detailedTransfers: Bool? = true
    public let transitModes: [TransportationMode]?
    public let numItineraries: Int?
    public let pageCursor: String?
    public let timetableView: Bool
    public let maxPreTransitTime: Int?
    public let maxPostTransitTime: Int?
    
    public init(from: (Double, Double), to: (Double, Double), via: [String]?, viaMinimumStay: [Int], time: Date?, arriveBy: Bool, maxTransfers: Int, minTransferTime: Int, pedestrianProfile: PedestrianProfile, transitModes: [TransportationMode]?, numItineraries: Int?, pageCursor: String?, timetableView: Bool, maxPreTransitTime: Int?, maxPostTransitTime: Int?) {
        self.from = from
        self.to = to
        self.via = via
        self.viaMinimumStay = viaMinimumStay
        self.time = time
        self.arriveBy = arriveBy
        self.maxTransfers = maxTransfers
        self.minTransferTime = minTransferTime
        self.pedestrianProfile = pedestrianProfile
        self.transitModes = transitModes
        self.numItineraries = numItineraries
        self.pageCursor = pageCursor
        self.timetableView = timetableView
        self.maxPreTransitTime = maxPreTransitTime
        self.maxPostTransitTime = maxPostTransitTime
    }
}
