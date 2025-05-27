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
    public var id: String { lineDisruption }
}
