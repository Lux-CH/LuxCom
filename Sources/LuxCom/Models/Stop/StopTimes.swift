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

    public func filteredToStation(stopId: String, name: String? = nil, lat: Double? = nil, lon: Double? = nil, servesRail: Bool = false, groupedStopIds: [String] = []) -> StopTimes {
        let targetName = name.map(StopGrouping.normalizedName)
        let memberIds = Set(groupedStopIds)

        func isHome(_ st: StopTime) -> Bool {
            if st.place.parentId == stopId || st.place.stopId == stopId {
                return true
            }

            if !memberIds.isEmpty,
               let id = st.place.parentId ?? st.place.stopId,
               memberIds.contains(id) {
                return true
            }

            guard let targetName, let lat, let lon else { return false }
            return StopGrouping.isSameStop(
                name: st.place.name, lat: st.place.lat, lon: st.place.lon,
                asNormalizedName: targetName, lat: lat, lon: lon
            )
        }

        let homeFlags = stopTimes.map(isHome)
        var home: [StopTime] = []
        var extras: [StopTime] = []
        for (stopTime, isHome) in zip(stopTimes, homeFlags) {
            if isHome { home.append(stopTime) } else { extras.append(stopTime) }
        }
        guard !extras.isEmpty, !home.isEmpty else { return self }

        let homeServesRail = servesRail || home.contains { $0.mode.isRail }
        let keepExtra: (StopTime) -> Bool

        if !homeServesRail {
            let servesStation = name.map(StopGrouping.isStationForecourt) ?? true
            keepExtra = servesStation ? { $0.mode.isRail } : { _ in false }
        } else {
            let localExtras = extras.filter { !$0.mode.isRail }
            let forecourtIds = Set(localExtras
                .filter { Self.isStationForecourt($0.place.name) }
                .compactMap { $0.place.parentId ?? $0.place.stopId })
            if !forecourtIds.isEmpty {
                keepExtra = { stopTime in
                    guard !stopTime.mode.isRail,
                          let id = stopTime.place.parentId ?? stopTime.place.stopId
                    else { return false }
                    return forecourtIds.contains(id)
                }
            } else if let lat, let lon,
                      let nearestStation = localExtras.min(by: {
                          Self.squaredDistance($0.place, lat: lat, lon: lon)
                              < Self.squaredDistance($1.place, lat: lat, lon: lon)
                      }).flatMap({ $0.place.parentId ?? $0.place.stopId }) {
                keepExtra = { stopTime in
                    guard !stopTime.mode.isRail,
                          let id = stopTime.place.parentId ?? stopTime.place.stopId
                    else { return false }
                    return id == nearestStation
                }
            } else {
                keepExtra = { !$0.mode.isRail }
            }
        }

        return StopTimes(
            stopTimes: zip(stopTimes, homeFlags).compactMap { stopTime, isHome in
                isHome || keepExtra(stopTime) ? stopTime : nil
            },
            previousPageCursor: previousPageCursor,
            nextPageCursor: nextPageCursor
        )
    }

    private static func isStationForecourt(_ name: String) -> Bool {
        StopGrouping.isStationForecourt(name)
    }

    private static func squaredDistance(_ place: Place, lat: Double, lon: Double) -> Double {
        let dLat = place.lat - lat
        let dLon = (place.lon - lon) * cos(lat * .pi / 180)
        return dLat * dLat + dLon * dLon
    }
}
