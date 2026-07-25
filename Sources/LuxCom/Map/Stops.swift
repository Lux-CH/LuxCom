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
        
        let stops = try await getMapStops(min: bbox.min, max: bbox.max)
        
        var seen = Set<String>()
        var uniqueStops: [Place] = []
        for place in stops {
            let id = place.parentId ?? place.stopId ?? ""
            if !id.isEmpty && seen.insert(id).inserted {
                uniqueStops.append(place)
            }
        }

        let groups = groupPlacesByStop(uniqueStops)

        if !groups.isEmpty {
            let results = groups.compactMap { group -> SearchResult? in
                let distances = group.map {
                    calculateDistance(
                        userLat: currentLoc.0,
                        userLon: currentLoc.1,
                        stopLat: $0.lat,
                        stopLon: $0.lon
                    )
                }
                guard let nearest = distances.indices.min(by: { distances[$0] < distances[$1] }) else {
                    return nil
                }

                let identifying = group.first { $0.parentId != nil } ?? group[nearest]
                guard let id = identifying.parentId ?? identifying.stopId, !id.isEmpty else {
                    return nil
                }

                var modes: [TransportationMode] = []
                for place in group {
                    for mode in place.modes where !modes.contains(mode) {
                        modes.append(mode)
                    }
                }

                let score = max(0.0, 1.0 - (distances[nearest] / radius))
                return SearchResult(
                    type: .stop,
                    tokens: [[]],
                    name: identifying.name,
                    id: id,
                    lat: group[nearest].lat,
                    lon: group[nearest].lon,
                    level: group[nearest].level,
                    street: nil,
                    houseNumber: nil,
                    zip: nil,
                    areas: [],
                    score: score,
                    modes: modes
                )
            }
            .sorted { $0.score > $1.score }

            return results
        }
        
        print("no stops found within \(radius), expanding..")
    }
    return []
}

func groupPlacesByStop(_ places: [Place]) -> [[Place]] {
    var groups: [[Place]] = []
    var names: [String] = []

    for place in places {
        let name = StopGrouping.normalizedName(place.name)
        let match = groups.indices.first { index in
            names[index] == name && groups[index].contains { member in
                StopGrouping.distance(
                    lat1: member.lat, lon1: member.lon,
                    lat2: place.lat, lon2: place.lon
                ) <= StopGrouping.maxDistance
            }
        }

        if let match {
            groups[match].append(place)
        } else {
            groups.append([place])
            names.append(name)
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
