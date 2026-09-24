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
    public let tripIds: [String]?
    public let stopIds: [String]?
    public let sourceId: String?
    public let title: String?
    public let text: String?
    public let periods: [Period]?
    public var id: String { sourceId ?? lineDisruption }

    public struct Period: Hashable, Sendable, Decodable {
        public let from: Date?
        public let until: Date?
    }

    public func isActive(from start: Date, to end: Date) -> Bool {
        guard let periods, !periods.isEmpty else { return true }
        return periods.contains { ($0.from ?? .distantPast) <= end && start <= ($0.until ?? .distantFuture) }
    }
}
