//
//  SearchResult.swift
//  LuxCom
//
//  Created by Constantin Clerc on 24.03.2025.
//

import Foundation

public struct SearchResult: Codable, Identifiable {
    let type: LocationType
    let tokens: [[Int]]
    let name: String
    public let id: String
    let lat: Double
    let lon: Double
    let level: Double?
    let street: String?
    let houseNumber: String?
    let zip: String?
    let areas: [Area]
    let score: Double
    
    struct Area: Codable {
        let name: String
        let adminLevel: Int
        let matched: Bool
        let `default`: Bool?
        
        enum CodingKeys: String, CodingKey {
            case name
            case adminLevel
            case matched
            case `default` = "default"
        }
    }
}
