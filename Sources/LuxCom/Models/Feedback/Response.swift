//
//  Response.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

public struct InfoResponse: Decodable {
    struct AttributeInfo: Decodable {
        let level: Double
        let trustLevel: Double
        let reportCount: Int
        let totalWeight: Double
    }
    
    struct RealtimeInfo: Decodable {
        let level: Int
        let trustLevel: Int
        let timestamp: Int64
        let distance: Double
    }
    
    let average: [String: AttributeInfo]
    let rt: [String: RealtimeInfo]?
}
