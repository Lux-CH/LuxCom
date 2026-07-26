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
    public static let familyMaxDistance: Double = 350

    public static func normalizedName(_ name: String) -> String {
        name
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static let genericLocationTerms: Set<String> = [
        "centre", "gare", "place", "douane", "gare cornavin", "p+r", "bahnhof", "stazione"
    ]

    public static func isGenericLocationTerm(_ term: String) -> Bool {
        genericLocationTerms.contains(term.trimmingCharacters(in: .whitespaces).lowercased())
    }

    public static func stationFamily(_ name: String) -> String {
        var base = normalizedName(name)
        if let slash = base.firstIndex(of: "/") {
            base = String(base[base.startIndex..<slash])
        }
        let parts = base
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        guard parts.count > 1, isStationForecourt(parts[1]) else {
            return base.trimmingCharacters(in: .whitespaces).lowercased()
        }
        return parts[0].lowercased()
    }

    public static func isStationForecourt(_ name: String) -> Bool {
        let n = name.lowercased()
        return n.contains("gare") || n.contains("bahnhof") || n.contains("stazione")
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
