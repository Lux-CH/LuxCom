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

public struct StepInstruction: Codable, Sendable {
    let relativeDirection: Direction
    let distance: Double
    let fromLevel: Int
    let toLevel: Int
    let osmWay: Int?
    let streetName: String
    let exit: String
    let stayOn: Bool
    let area: Bool
}
