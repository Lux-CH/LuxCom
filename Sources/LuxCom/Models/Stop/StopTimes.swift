//
//  StopTimes.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public struct StopTimes: Codable {
    let stopTimes: [StopTime]
    let previousPageCursor: String
    let nextPageCursor: String
}
