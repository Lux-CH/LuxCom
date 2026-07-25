//
//  StopGrouping.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.07.2026.
//

import Foundation

public let departureRadiusMeters: Double = 300

public enum StopGrouping {
    public static let maxDistance: Double = 200

    public static func normalizedName(_ name: String) -> String {
        name
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func distance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let earthRadius = 6_371_000.0
        let dLat = (lat2 - lat1) * .pi / 180
        let dLon = (lon2 - lon1) * .pi / 180 * cos((lat1 + lat2) / 2 * .pi / 180)
        return earthRadius * (dLat * dLat + dLon * dLon).squareRoot()
    }

    public static func isSameStop(
        name: String,
        lat: Double,
        lon: Double,
        asName otherName: String,
        lat otherLat: Double,
        lon otherLon: Double,
        within limit: Double = maxDistance
    ) -> Bool {
        isSameStop(
            name: name, lat: lat, lon: lon,
            asNormalizedName: normalizedName(otherName), lat: otherLat, lon: otherLon,
            within: limit
        )
    }

    public static func isSameStop(
        name: String,
        lat: Double,
        lon: Double,
        asNormalizedName otherName: String,
        lat otherLat: Double,
        lon otherLon: Double,
        within limit: Double = maxDistance
    ) -> Bool {
        distance(lat1: lat, lon1: lon, lat2: otherLat, lon2: otherLon) <= limit
            && normalizedName(name) == otherName
    }
}
