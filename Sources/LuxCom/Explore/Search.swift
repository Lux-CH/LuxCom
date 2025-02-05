//
//  Search.swift
//  LuxCom
//
//  Created by Constantin Clerc on 05.02.2025.
//

import OJP

public func searchForStop(ojpConfig: OJP, stop: String) async throws -> [OJPv2.PlaceResult] {
    return try await ojpConfig.requestPlaceResults(
        from: stop,
        restrictions: .init(type: [.stop])
    )
}

public func searchForCords(ojpConfig: OJP, coordinates: Point) async throws -> [NearbyObject<OJPv2.PlaceResult>] {
    return try await ojpConfig.requestPlaceResults(from: coordinates)
}
