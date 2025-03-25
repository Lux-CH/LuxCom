//
//  SharedFormatters.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.03.2025.
//

import Foundation

/// Shared date formatters to improve performance and ensure consistency
enum SharedFormatters {
    /// ISO8601 formatter with internet date time format
    @MainActor
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    /// JSON decoder with ISO8601 date decoding strategy
    @MainActor
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
