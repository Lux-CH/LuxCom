//
//  Stops.swift
//  LuxCom
//
//  Created by Constantin Clerc on 29.06.2025.
//

import Foundation
import CoreLocation

public func getMapStops(min: (Double, Double), max: (Double, Double)) async throws -> [Place] {
    let queryItems = [URLQueryItem(name: "min", value: "\(min.0), \(min.1)"), URLQueryItem(name: "max", value: "\(max.0), \(max.1)")]
    return try await APIClient.fetch(from: "/map/stops", queryItems: queryItems)
}

public func getMapSearchResults(currentLoc: (Double, Double)) async throws -> [SearchResult] {
    for radius in [500.0, 1000.0, 5000.0] {
        let bbox = calculateBoundingBox(center: currentLoc, radiusMeters: radius)
        let fetchBox = calculateBoundingBox(center: currentLoc, radiusMeters: radius + departureRadiusMeters)

        let stops = try await getMapStops(min: fetchBox.min, max: fetchBox.max)

        var seen: [String: Int] = [:]
        var uniqueStops: [Place] = []
        var pointsById: [String: [(Double, Double)]] = [:]
        for place in stops {
            let id = place.parentId ?? place.stopId ?? ""
            guard !id.isEmpty else { continue }
            pointsById[id, default: []].append((place.lat, place.lon))
            if let index = seen[id] {
                for mode in place.modes where !uniqueStops[index].modes.contains(mode) {
                    uniqueStops[index].modes.append(mode)
                }
            } else {
                seen[id] = uniqueStops.count
                uniqueStops.append(place)
            }
        }

        let groups = groupPlacesByStop(uniqueStops)
        let neighbourhood = groups.map { group -> (points: [(Double, Double)], servesRail: Bool) in
            var points: [(Double, Double)] = []
            var servesRail = false
            for place in group {
                let id = place.parentId ?? place.stopId ?? ""
                points.append(contentsOf: pointsById[id] ?? [(place.lat, place.lon)])
                servesRail = servesRail || place.modes.contains { $0.isRail }
            }
            return (points, servesRail)
        }

        var railPoints: [(lat: Double, lon: Double, group: Int)] = []
        for (index, entry) in neighbourhood.enumerated() where entry.servesRail {
            railPoints.append(contentsOf: entry.points.map { (lat: $0.0, lon: $0.1, group: index) })
        }
        let maxLatDelta = departureRadiusMeters / 111_000 * 1.1
        let maxLonDelta = maxLatDelta / cos(currentLoc.0 * .pi / 180)

        if !groups.isEmpty {
            let results = groups.enumerated().compactMap { groupIndex, group -> SearchResult? in
                let closest = group.map { place -> (distance: Double, lat: Double, lon: Double) in
                    let id = place.parentId ?? place.stopId ?? ""
                    let candidates = pointsById[id] ?? [(place.lat, place.lon)]
                    var best = (distance: Double.greatestFiniteMagnitude, lat: place.lat, lon: place.lon)
                    for point in candidates {
                        let distance = StopGrouping.distance(
                            lat1: currentLoc.0, lon1: currentLoc.1,
                            lat2: point.0, lon2: point.1
                        )
                        if distance < best.distance {
                            best = (distance, point.0, point.1)
                        }
                    }
                    return best
                }
                guard let nearest = closest.indices.min(by: { closest[$0].distance < closest[$1].distance }) else {
                    return nil
                }

                let ranked = group.filter { $0.importance != nil }.max { lhs, rhs in
                    let l = lhs.importance ?? -1, r = rhs.importance ?? -1
                    if l != r { return l < r }
                    return !lhs.modes.contains { $0.isRail } && rhs.modes.contains { $0.isRail }
                }
                let identifying = ranked ?? group.first { $0.parentId != nil } ?? group[nearest]
                guard let id = identifying.parentId ?? identifying.stopId, !id.isEmpty else {
                    return nil
                }

                var modes: [TransportationMode] = []
                for place in group {
                    for mode in place.modes where !modes.contains(mode) {
                        modes.append(mode)
                    }
                }

                let points = neighbourhood[groupIndex].points
                guard points.contains(where: {
                    $0.0 >= bbox.min.0 && $0.0 <= bbox.max.0 && $0.1 >= bbox.min.1 && $0.1 <= bbox.max.1
                }) else {
                    return nil
                }

                let hasRailNeighbour = railPoints.contains { other in
                    guard other.group != groupIndex else { return false }
                    return points.contains { point in
                        abs(point.0 - other.lat) <= maxLatDelta
                            && abs(point.1 - other.lon) <= maxLonDelta
                            && StopGrouping.distance(lat1: point.0, lon1: point.1, lat2: other.lat, lon2: other.lon)
                                <= departureRadiusMeters
                    }
                }

                var groupedStopIds: [String] = []
                for place in group {
                    let memberId = place.parentId ?? place.stopId ?? ""
                    if !memberId.isEmpty && !groupedStopIds.contains(memberId) {
                        groupedStopIds.append(memberId)
                    }
                }

                let score = max(0.0, 1.0 - (closest[nearest].distance / radius))
                return SearchResult(
                    type: .stop,
                    tokens: [[]],
                    name: identifying.name,
                    id: id,
                    lat: closest[nearest].lat,
                    lon: closest[nearest].lon,
                    level: group[nearest].level,
                    street: nil,
                    houseNumber: nil,
                    zip: nil,
                    areas: [],
                    score: score,
                    modes: modes,
                    groupedStopIds: groupedStopIds,
                    hasRailNeighbour: hasRailNeighbour
                )
            }
            .sorted { $0.score > $1.score }

            if !results.isEmpty {
                return results
            }
        }
        
        print("no stops found within \(radius), expanding..")
    }
    return []
}

func groupPlacesByStop(_ places: [Place]) -> [[Place]] {
    var groups: [[Place]] = []
    var groupsByFamily: [String: [Int]] = [:]

    for place in places {
        let family = StopGrouping.stationFamily(place.name)
        let name = StopGrouping.normalizedName(place.name)
        let candidates = groupsByFamily[family] ?? []
        let match = candidates.first { index in
            groups[index].contains { member in
                let limit = StopGrouping.normalizedName(member.name) == name
                    ? StopGrouping.maxDistance
                    : StopGrouping.familyMaxDistance
                return StopGrouping.distance(
                    lat1: member.lat, lon1: member.lon,
                    lat2: place.lat, lon2: place.lon
                ) <= limit
            }
        }

        if let match {
            groups[match].append(place)
        } else {
            groupsByFamily[family, default: []].append(groups.count)
            groups.append([place])
        }
    }

    return groups
}

public func calculateDistance(userLat: Double, userLon: Double, stopLat: Double, stopLon: Double) -> Double {
    let userLocation = CLLocation(latitude: userLat, longitude: userLon)
    let stopLocation = CLLocation(latitude: stopLat, longitude: stopLon)
    return userLocation.distance(from: stopLocation)
}

func calculateBoundingBox(center: (Double, Double), radiusMeters: Double) -> (min: (Double, Double), max: (Double, Double)) {
    let (lat, lon) = center
    
    let earthRadius = 6371000.0
    
    let angularDistance = radiusMeters / earthRadius
    
    let latOffset = angularDistance * (180.0 / .pi)
    
    let lonOffset = angularDistance * (180.0 / .pi) / cos(lat * .pi / 180.0)
    
    let minLat = lat - latOffset
    let maxLat = lat + latOffset
    let minLon = lon - lonOffset
    let maxLon = lon + lonOffset
    
    return (min: (minLat, minLon), max: (maxLat, maxLon))
}
