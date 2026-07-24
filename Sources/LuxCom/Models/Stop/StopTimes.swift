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

    /// When departures are fetched with a `radius`, MOTIS returns every stop
    /// physically within that radius — including unrelated same-class
    /// neighbours (e.g. at *Genève, Stand* it also returns *Genève, Bel-Air*).
    /// The feature only wants to pair a train station with its co-located
    /// local-transit stop, so keep the opened station's own departures plus
    /// only the *complementary* rail/local class from the neighbours:
    ///   - opened stop is local (bus/tram) → keep only rail departures nearby;
    ///   - opened stop is rail → keep only local departures from the single
    ///     nearest neighbouring station.
    ///
    /// Classification uses each departure's own `mode` (not the aggregated
    /// `place.modes`, which footpath-linking pollutes). `stopId` is the opened
    /// station id (a parent station); `lat`/`lon` its coordinates.
    public func filteredToStation(stopId: String, lat: Double, lon: Double) -> StopTimes {
        func isHome(_ st: StopTime) -> Bool {
            st.place.parentId == stopId || st.place.stopId == stopId
        }

        let home = stopTimes.filter(isHome)
        let extras = stopTimes.filter { !isHome($0) }

        // No neighbours pulled in (or the opened stop didn't match anything):
        // nothing to filter.
        guard !extras.isEmpty, !home.isEmpty else { return self }

        let homeServesRail = home.contains { $0.mode.isRail }

        let keptExtras: [StopTime]
        if !homeServesRail {
            // Local station: keep only the adjacent rail departures.
            keptExtras = extras.filter { $0.mode.isRail }
        } else {
            // Rail station: keep only local departures, and only from the
            // single nearest neighbouring station.
            let localExtras = extras.filter { !$0.mode.isRail }
            let nearestStation = localExtras.min {
                Self.squaredDistance($0.place, lat: lat, lon: lon)
                    < Self.squaredDistance($1.place, lat: lat, lon: lon)
            }.map { $0.place.parentId ?? $0.place.stopId }
            keptExtras = localExtras.filter { ($0.place.parentId ?? $0.place.stopId) == nearestStation }
        }

        return StopTimes(
            stopTimes: home + keptExtras,
            previousPageCursor: previousPageCursor,
            nextPageCursor: nextPageCursor
        )
    }

    /// Planar squared distance with longitude correction — order-preserving,
    /// so adequate for "nearest station" comparisons at city scale.
    private static func squaredDistance(_ place: Place, lat: Double, lon: Double) -> Double {
        let dLat = place.lat - lat
        let dLon = (place.lon - lon) * cos(lat * .pi / 180)
        return dLat * dLat + dLon * dLon
    }
}
