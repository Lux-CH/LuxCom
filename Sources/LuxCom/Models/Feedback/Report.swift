//
//  Report.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

import Foundation

public enum ReportAttribute: String, Codable, Hashable {
    case crowd
    case smell
    case clean
    case heat
    case noise
}

public struct Report: Codable, Hashable {
    public let tripId: String
    public let routeShortName: String
    public let latitude: Double
    public let longitude: Double
    public let attribute: ReportAttribute
    public let level: Int
    public init(tripId: String, routeShortName: String, latitude: Double, longitude: Double, attribute: ReportAttribute, level: Int) {
        self.tripId = tripId
        self.routeShortName = routeShortName
        self.latitude = latitude
        self.longitude = longitude
        self.attribute = attribute
        self.level = level
    }
}
