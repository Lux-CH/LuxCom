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

private func isGatewayFailure(_ statusCode: Int) -> Bool {
    switch statusCode {
    case 502, 503, 504, 530:
        return true
    case 520...527:
        return true
    default:
        return false
    }
}

private enum ConnectionError: Error {
    case underlying(Error)

    var underlyingError: Error {
        switch self {
        case .underlying(let error): return error
        }
    }

    var isLocalConnectivity: Bool {
        guard let urlError = underlyingError as? URLError else { return false }
        switch urlError.code {
        case .notConnectedToInternet, .dataNotAllowed, .internationalRoamingOff, .callIsActive:
            return true
        default:
            return false
        }
    }
}

private let sharedSession: URLSession = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 5
    config.timeoutIntervalForResource = 15
    return URLSession(configuration: config)
}()

private let primaryRetryTimeout: TimeInterval = 2.5

// Reused across every request: constructing a JSONDecoder per call is wasteful
// on the hot polling paths (departures every 5s, trip refresh every 10s). The
// decoder is only read concurrently (never reconfigured), which is safe.
private let sharedDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()

actor APIState {
    static let shared = APIState()

    private var primaryProven = false
    private var failureStreak = 0
    private var streakStartedAt: Date = .distantPast
    private var lastFailureAt: Date = .distantPast
    private var backupUntil: Date = .distantPast

    private let backupPeriod: TimeInterval = 30
    private let failuresBeforeSwitch = 3
    private let sustainedFailureWindow: TimeInterval = 8
    private let streakMemory: TimeInterval = 60

    func shouldUsePrimary() -> Bool {
        guard Date() >= backupUntil else { return false }
        if backupUntil != .distantPast {
            backupUntil = .distantPast
            failureStreak = 0
        }
        return true
    }

    func shouldRetryPrimary() -> Bool {
        primaryProven
    }

    func markPrimaryReachable() {
        primaryProven = true
        failureStreak = 0
        backupUntil = .distantPast
    }

    func recordPrimaryFailure() -> Bool {
        let now = Date()
        if failureStreak == 0 || now.timeIntervalSince(lastFailureAt) > streakMemory {
            failureStreak = 0
            streakStartedAt = now
        }
        failureStreak += 1
        lastFailureAt = now

        let sustained = failureStreak >= failuresBeforeSwitch
            && now.timeIntervalSince(streakStartedAt) >= sustainedFailureWindow
        guard sustained || !primaryProven else { return false }

        backupUntil = now.addingTimeInterval(backupPeriod)
        return true
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
            do {
                return try await performRequest(
                    from: endpoint,
                    apiVersion: apiVersion,
                    queryItems: queryItems,
                    baseURL: baseURL,
                    headers: headers,
                    method: method,
                    body: body
                )
            } catch let error as ConnectionError {
                throw error.underlyingError
            }
        }

        let state = APIState.shared

        func requestBackup() async throws -> T {
            do {
                return try await performRequest(
                    from: endpoint,
                    apiVersion: apiVersion,
                    queryItems: queryItems,
                    baseURL: bckpApiUrl,
                    headers: headers,
                    method: method,
                    body: body
                )
            } catch let error as ConnectionError {
                throw error.underlyingError
            }
        }

        func requestPrimary(timeout: TimeInterval?) async throws -> T {
            do {
                let result: T = try await performRequest(
                    from: endpoint,
                    apiVersion: apiVersion,
                    queryItems: queryItems,
                    baseURL: apiUrl,
                    headers: headers,
                    method: method,
                    body: body,
                    timeout: timeout
                )
                await state.markPrimaryReachable()
                return result
            } catch is CancellationError {
                throw CancellationError()
            } catch let error as ConnectionError {
                throw error
            } catch {
                await state.markPrimaryReachable()
                throw error
            }
        }

        guard await state.shouldUsePrimary() else {
            return try await requestBackup()
        }

        do {
            return try await requestPrimary(timeout: nil)
        } catch let error as ConnectionError {
            guard !error.isLocalConnectivity else { throw error.underlyingError }

            if await state.shouldRetryPrimary() {
                do {
                    return try await requestPrimary(timeout: primaryRetryTimeout)
                } catch let retryError as ConnectionError {
                    guard !retryError.isLocalConnectivity else { throw retryError.underlyingError }
                }
            }

            if await state.recordPrimaryFailure() {
                print("Primary server unreachable, staying on backup for now")
            }
            return try await requestBackup()
        }
    }
    
    private static func performRequest<T: Decodable>(
        from endpoint: String,
        apiVersion: String,
        queryItems: [URLQueryItem]?,
        baseURL: String,
        headers: [String: String],
        method: String,
        body: Data?,
        timeout: TimeInterval? = nil
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

        if let timeout = timeout {
            request.timeoutInterval = timeout
        }

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
        } catch is CancellationError {
            throw CancellationError()
        } catch let urlError as URLError where urlError.code == .cancelled {
            throw CancellationError()
        } catch {
            throw ConnectionError.underlying(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(statusCode: 0, description: "Invalid Response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let failure = APIError.requestFailed(
                statusCode: httpResponse.statusCode,
                description: String(data: data, encoding: .utf8)
            )
            if isGatewayFailure(httpResponse.statusCode) {
                throw ConnectionError.underlying(failure)
            }
            throw failure
        }
        
        do {
            return try sharedDecoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
