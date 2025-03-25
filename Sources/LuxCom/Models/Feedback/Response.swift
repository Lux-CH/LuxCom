//
//  Response.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

public struct InfoResponse: Decodable, Sendable {
    struct AttributeInfo: Decodable, Sendable {
        let level: Double
        let trustLevel: Double
        let reportCount: Int
        let totalWeight: Double
    }
    
    struct RealtimeInfo: Decodable, Sendable {
        let level: Int
        let trustLevel: Int
        let timestamp: Int64
        let distance: Double
    }
    
    let average: [String: AttributeInfo]
    let rt: [String: RealtimeInfo]?
}
