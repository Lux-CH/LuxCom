//
//  Disruption.swift
//  LuxCom
//
//  Created by Constantin Clerc on 27.05.2025.
//

import SwiftUI

public struct Disruption: Identifiable, Hashable, Sendable, Decodable {
    public let line: String
    public let lineBackground: String // HEX
    public let lineDisruption: String
    public let agencyId: String?
    public let tripId: String?
    public var id: String { lineDisruption }

    public init(line: String, lineBackground: String, lineDisruption: String, agencyId: String? = nil, tripId: String? = nil) {
        self.line = line
        self.lineBackground = lineBackground
        self.lineDisruption = lineDisruption
        self.agencyId = agencyId
        self.tripId = tripId
    }
}
