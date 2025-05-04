//
//  APIClient.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.03.2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(statusCode: Int, description: String? = nil)
    case decodingFailed(Error)
}

struct APIClient {
    static func fetch<T: Decodable>(
        from endpoint: String,
        apiVersion: String = "v1",
        queryItems: [URLQueryItem],
        baseURL: String = apiUrl,
        headers: [String: String] = [:],
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        guard var components = URLComponents(string: "\(baseURL)/\(apiVersion)\(endpoint)") else {
            throw APIError.invalidURL
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        print(components)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
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
        } catch {
            if let apiError = error as? APIError {
                throw apiError
            }
            throw error
        }
    }
}
