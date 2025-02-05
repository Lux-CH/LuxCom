//
//  StopEvents.swift
//  LuxCom
//
//  Created by Constantin Clerc on 05.02.2025.
//

import Foundation
import OJP

public func loadStopEvents(ojpConfig: OJP, stop: OJPv2.PlaceRefChoice, targetTime: Date? = nil, type: OJPv2.StopEventType = .departure, numberOfResults: Int) async throws -> [OJPv2.StopEventResult] {
    let events = try await ojpConfig.requestStopEvent(location: .init(
        placeRef: stop,
        depArrTime: targetTime
    ), params: .init(
        stopEventType: type,
        numberOfResults: numberOfResults
    ))
    return events.stopEventResults
}
