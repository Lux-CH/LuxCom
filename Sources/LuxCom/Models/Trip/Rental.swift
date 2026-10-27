//
//  Rental.swift
//  LuxCom
//
//  Created by Constantin Clerc on 27.10.2026.
//

import Foundation

public struct Rental: Codable, Hashable, Sendable {
    public let systemId: String?
    public let systemName: String?
    public let providerId: String?
    public let url: String?
    public let color: String?
    public let fromStationName: String?
    public let toStationName: String?
    public let rentalUriIOS: String?
    public let rentalUriWeb: String?
    public let formFactor: String?
    public let propulsionType: String?
    public let returnConstraint: String?

    public var isElectric: Bool {
        guard let propulsionType else { return false }
        return propulsionType.hasPrefix("ELECTRIC")
    }

    public var returnsToStation: Bool {
        returnConstraint == "ANY_STATION" || returnConstraint == "ROUNDTRIP_STATION"
    }
}
