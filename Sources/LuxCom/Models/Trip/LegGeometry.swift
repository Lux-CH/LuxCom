//
//  LegGeometry.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.04.2025.
//

import Foundation

public struct LegGeometry: Codable, Sendable {
    public let points: String // the encoded points of the polyline, Google polyline encoding, precision 7
    public let length: Int // the number of points in the string
}
