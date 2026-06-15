//
//  Route.swift
//  LuxCom
//
//  Created by Constantin Clerc on 20.03.2025.
//

import Foundation

nonisolated(unsafe) private let routeDateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]
    return formatter
}()

public func getRoute(_ options: RouteOptions) async throws -> Trip {
    let dateFormatter = routeDateFormatter

    var queryItems = [
        URLQueryItem(name: "fromPlace", value: options.from.queryValue),
        URLQueryItem(name: "toPlace", value: options.to.queryValue),
        URLQueryItem(name: "arriveBy", value: String(options.arriveBy)),
        URLQueryItem(name: "maxTransfers", value: String(options.maxTransfers)),
        URLQueryItem(name: "additionalTransferTime", value: String(options.minTransferTime)),
        URLQueryItem(name: "pedestrianProfile", value: options.pedestrianProfile.rawValue),
        URLQueryItem(name: "useRoutedTransfers", value: String(options.useRoutedTransfers ?? true)),
        URLQueryItem(name: "maxMatchingDistance", value: String(options.maxMatchingDistance ?? 250)),
        URLQueryItem(name: "detailedTransfers", value: String(options.detailedTransfers ?? true)),
        URLQueryItem(name: "timetableView", value: String(options.timetableView)),
        URLQueryItem(name: "fastestDirectFactor", value: "1.5")
    ]
    
    if let time = options.time {
        queryItems.append(URLQueryItem(name: "time", value: dateFormatter.string(from: time)))
    }
    
    if let via = options.via, !via.isEmpty {
        for viaStop in via {
            queryItems.append(URLQueryItem(name: "via", value: viaStop))
        }
    }
    
    if !options.viaMinimumStay.isEmpty {
        for stayTime in options.viaMinimumStay {
            queryItems.append(URLQueryItem(name: "viaMinimumStay", value: String(stayTime)))
        }
    }
    
    if let transitModes = options.transitModes, !transitModes.isEmpty {
        for mode in transitModes {
            queryItems.append(URLQueryItem(name: "transitModes", value: mode.rawValue))
        }
    }
    
    if let numItineraries = options.numItineraries {
        queryItems.append(URLQueryItem(name: "numItineraries", value: String(numItineraries)))
    }
    
    if let speed = options.pedestrianSpeed, speed != 1.2 {
        queryItems.append(URLQueryItem(name: "pedestrianSpeed", value: String(speed)))
    }
    
    if let pageCursor = options.pageCursor {
        queryItems.append(URLQueryItem(name: "pageCursor", value: pageCursor))
    }
    
    if let maxPreTransitTime = options.maxPreTransitTime {
        queryItems.append(URLQueryItem(name: "maxPreTransitTime", value: String(maxPreTransitTime)))
    }
    
    if let maxPostTransitTime = options.maxPostTransitTime {
        queryItems.append(URLQueryItem(name: "maxPostTransitTime", value: String(maxPostTransitTime)))
    }
    
    if let numLegAlternatives = options.numLegAlternatives {
        queryItems.append(URLQueryItem(name: "numLegAlternatives", value: String(numLegAlternatives)))
    }
    
    return try await APIClient.fetch(from: "/plan", apiVersion: "v4", queryItems: queryItems)
}
