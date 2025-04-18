//
//  Response.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

public struct InfoResponse: Decodable, Sendable {
    public struct AttributeInfo: Decodable, Sendable {
        public let level: Double
        public let trustLevel: Double
        public let reportCount: Int
        public let totalWeight: Double
    }
    
    public struct RealtimeInfo: Decodable, Sendable {
        public let level: Int
        public let trustLevel: Int
        public let timestamp: Int64
        public let distance: Double
    }
    
    public let average: [String: AttributeInfo]
    public let rt: [String: RealtimeInfo]?
}
