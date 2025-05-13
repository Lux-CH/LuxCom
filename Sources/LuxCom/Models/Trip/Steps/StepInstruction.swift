//
//  StepInstruction.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

public enum Direction: String, Codable, Sendable {
    case depart = "DEPART"
    case hardLeft = "HARD_LEFT"
    case left = "LEFT"
    case slightlyLeft = "SLIGHTLY_LEFT"
    case continueStraight = "CONTINUE"
    case slightlyRight = "SLIGHTLY_RIGHT"
    case right = "RIGHT"
    case hardRight = "HARD_RIGHT"
    case circleClockwise = "CIRCLE_CLOCKWISE"
    case circleCounterClockwise = "CIRCLE_COUNTERCLOCKWISE"
    case stairs = "STAIRS"
    case elevator = "ELEVATOR"
    case uturnLeft = "UTURN_LEFT"
    case uturnRight = "UTURN_RIGHT"
}

public struct StepInstruction: Codable, Sendable, Hashable {
    public let relativeDirection: Direction
    public let distance: Double
    public let fromLevel: Int
    public let toLevel: Int
    public let osmWay: Int?
    public let streetName: String
    public let exit: String
    public let stayOn: Bool
    public let area: Bool
    public let polyline: StepPolyline
    public init(relativeDirection: Direction, distance: Double, fromLevel: Int, toLevel: Int, osmWay: Int?, streetName: String, exit: String, stayOn: Bool, area: Bool, polyline: StepPolyline) {
        self.relativeDirection = relativeDirection
        self.distance = distance
        self.fromLevel = fromLevel
        self.toLevel = toLevel
        self.osmWay = osmWay
        self.streetName = streetName
        self.exit = exit
        self.stayOn = stayOn
        self.area = area
        self.polyline = polyline
    }
}

public struct StepPolyline: Codable, Sendable, Hashable {
    public let points: String
    public let precision: Int
    public let length: Int
    public init(points: String, precision: Int, length: Int) {
        self.points = points
        self.precision = precision
        self.length = length
    }
}
