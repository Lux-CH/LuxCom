//
//  StopTimes.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTimes: Codable, Sendable, Equatable {
    public let stopTimes: [StopTime]
    public let previousPageCursor: String
    public let nextPageCursor: String
    
    public init(stopTimes: [StopTime], previousPageCursor: String, nextPageCursor: String) {
        self.stopTimes = stopTimes
        self.previousPageCursor = previousPageCursor
        self.nextPageCursor = nextPageCursor
    }
}
