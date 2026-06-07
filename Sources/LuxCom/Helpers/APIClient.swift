//
//  APIClient.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.03.2025.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed(statusCode: Int, description: String? = nil)
    case decodingFailed(Error)
}

private enum ConnectionError: Error {
    case underlying(Error)
}

private let sharedSession: URLSession = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 5
    config.timeoutIntervalForResource = 15
    return URLSession(configuration: config)
}()

actor APIState {
    static let shared = APIState()
    
    var primaryServerAvailable = true
    var lastPrimaryCheck: Date = .distantPast
    let retryPrimaryAfter: TimeInterval = 30
    
    func shouldUsePrimary() -> Bool {
        if !primaryServerAvailable,
           Date().timeIntervalSince(lastPrimaryCheck) > retryPrimaryAfter {
            primaryServerAvailable = true
        }
        return primaryServerAvailable
    }
    
    func markPrimaryDown() {
        primaryServerAvailable = false
        lastPrimaryCheck = Date()
    }
}

struct APIClient {
    static func fetch<T: Decodable>(
        from endpoint: String,
        apiVersion: String = "v1",
        queryItems: [URLQueryItem]? = nil,
        baseURL: String? = nil,
        headers: [String: String] = [:],
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        if let baseURL = baseURL {
            return try await performRequest(
                from: endpoint,
                apiVersion: apiVersion,
                queryItems: queryItems,
                baseURL: baseURL,
                headers: headers,
                method: method,
                body: body
            )
        }
        
        let state = APIState.shared
        let usePrimary = await state.shouldUsePrimary()
        let resolvedURL = usePrimary ? apiUrl : bckpApiUrl
        
        do {
            return try await performRequest(
                from: endpoint,
                apiVersion: apiVersion,
                queryItems: queryItems,
                baseURL: resolvedURL,
                headers: headers,
                method: method,
                body: body
            )
        } catch {
            if usePrimary && Self.isConnectionError(error) {
                print("Primary server failed, switching to backup")
                await state.markPrimaryDown()
                return try await performRequest(
                    from: endpoint,
                    apiVersion: apiVersion,
                    queryItems: queryItems,
                    baseURL: bckpApiUrl,
                    headers: headers,
                    method: method,
                    body: body
                )
            }
            throw error
        }
    }
    
    private static func performRequest<T: Decodable>(
        from endpoint: String,
        apiVersion: String,
        queryItems: [URLQueryItem]?,
        baseURL: String,
        headers: [String: String],
        method: String,
        body: Data?
    ) async throws -> T {
        guard var components = URLComponents(string: "\(baseURL)/\(apiVersion)\(endpoint)") else {
            throw APIError.invalidURL
        }
        
        if let query = queryItems {
            components.queryItems = query
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.assumesHTTP3Capable = false
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await sharedSession.data(for: request)
        } catch {
            throw ConnectionError.underlying(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(statusCode: 0, description: "Invalid Response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed(
                statusCode: httpResponse.statusCode,
                description: String(data: data, encoding: .utf8)
            )
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }

    private static func isConnectionError(_ error: Error) -> Bool {
        return error is ConnectionError
    }
}
