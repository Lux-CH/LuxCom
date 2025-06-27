//
//  SendReport.swift
//  LuxCom
//
//  Created by Constantin Clerc on 23.03.2025.
//

import Foundation

@discardableResult
public func sendLCBReport(
    report: Report,
    baseURL: URL? = nil
) async throws -> ReportResponse {
    let baseURLString = baseURL?.absoluteString ?? cbURL
    let endpoint: String
    var bodyDict: [String: Any]
    
    switch report.attribute {
    case .crowd:
        endpoint = "/report/crowd"
        bodyDict = [
            "tripId": report.tripId,
            "routeShortName": report.routeShortName,
            "location": ["lat": report.latitude, "long": report.longitude],
            "crowdedness": report.level
        ]
    case .smell, .clean, .heat, .noise:
        endpoint = "/report/wellness"
        bodyDict = [
            "tripId": report.tripId,
            "routeShortName": report.routeShortName,
            "location": ["lat": report.latitude, "long": report.longitude],
            "attribute": report.attribute.rawValue,
            "level": report.level
        ]
    }
    
    let jsonData = try JSONSerialization.data(withJSONObject: bodyDict)
    let headers = [
        "Content-Type": "application/json",
    ]
    
    return try await APIClient.fetch(
        from: endpoint,
        apiVersion: "v1",
        queryItems: [],
        baseURL: baseURLString,
        headers: headers,
        method: "POST",
        body: jsonData
    )
}

public struct ReportResponse: Decodable, Sendable {
    let success: Bool
    let message: String
}
