//
//  StopTimes.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTimes: Codable, Sendable {
    public let stopTimes: [StopTime]
    public let previousPageCursor: String
    public let nextPageCursor: String
}
