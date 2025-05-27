//
//  GetDisruptions.swift
//  LuxCom
//
//  Created by Constantin Clerc on 27.05.2025.
//

import Foundation

public func getDisruptions() async throws -> Disruption {
    return try await APIClient.fetch(
        from: "/disruptions",
        queryItems: [],
        baseURL: disruptionsUrl,
    )
}
