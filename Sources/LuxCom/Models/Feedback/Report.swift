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
    let tripId: String
    let routeShortName: String
    let latitude: Double
    let longitude: Double
    let attribute: ReportAttribute
    let level: Int
}
