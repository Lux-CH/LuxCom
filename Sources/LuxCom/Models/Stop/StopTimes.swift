//
//  StopTimes.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public struct StopTimes: Codable, Sendable, Equatable {
    public let stopTimes: [StopTime]
    public let previousPageCursor: String
    public let nextPageCursor: String
    
    public init(stopTimes: [StopTime], previousPageCursor: String, nextPageCursor: String) {
        self.stopTimes = stopTimes
        self.previousPageCursor = previousPageCursor
        self.nextPageCursor = nextPageCursor
    }

    public func filteredToStation(stopId: String, lat: Double? = nil, lon: Double? = nil) -> StopTimes {
        func isHome(_ st: StopTime) -> Bool {
            st.place.parentId == stopId || st.place.stopId == stopId
        }

        let home = stopTimes.filter(isHome)
        let extras = stopTimes.filter { !isHome($0) }
        guard !extras.isEmpty, !home.isEmpty else { return self }

        let homeServesRail = home.contains { $0.mode.isRail }
        let keepExtra: (StopTime) -> Bool

        if !homeServesRail {
            keepExtra = { $0.mode.isRail }
        } else {
            let localExtras = extras.filter { !$0.mode.isRail }
            let forecourtIds = Set(localExtras
                .filter { Self.isStationForecourt($0.place.name) }
                .map { $0.place.parentId ?? $0.place.stopId })
            if !forecourtIds.isEmpty {
                keepExtra = { !$0.mode.isRail && forecourtIds.contains($0.place.parentId ?? $0.place.stopId) }
            } else if let lat, let lon {
                let nearestStation = localExtras.min {
                    Self.squaredDistance($0.place, lat: lat, lon: lon)
                        < Self.squaredDistance($1.place, lat: lat, lon: lon)
                }.map { $0.place.parentId ?? $0.place.stopId }
                keepExtra = { !$0.mode.isRail && ($0.place.parentId ?? $0.place.stopId) == nearestStation }
            } else {
                keepExtra = { !$0.mode.isRail }
            }
        }

        return StopTimes(
            stopTimes: stopTimes.filter { isHome($0) || keepExtra($0) },
            previousPageCursor: previousPageCursor,
            nextPageCursor: nextPageCursor
        )
    }

    private static func isStationForecourt(_ name: String) -> Bool {
        let n = name.lowercased()
        return n.contains("gare") || n.contains("bahnhof") || n.contains("stazione")
    }

    private static func squaredDistance(_ place: Place, lat: Double, lon: Double) -> Double {
        let dLat = place.lat - lat
        let dLon = (place.lon - lon) * cos(lat * .pi / 180)
        return dLat * dLat + dLon * dLon
    }
}
