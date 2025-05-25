//
//  NetworkService.swift
//  messenger_iOS
//
//  Created by Nikita Tsomuk on 17.07.2024.
//

import Foundation
import SwiftUI

//API INFO
/*
 https://aviationstack.com/dashboard - Flights Dashboard
 https://aviationstack.com/documentation - Flights Documentation
 */

// MARK: - Network layer

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}
    
enum Endpoint {
    static func flight(code: String) -> String { "https://api.aviationstack.com/v1/flights?flight_iata=\(code)&" }
}

struct AnyEncodable: Encodable {
    
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: any Encoder) throws {
        try encodable.encode(to: encoder)
    }
}


final class NetworkService {
    @AppStorage(UDKeys.apiKey) var apiKey: ApiKeyType = .primary
    
    private func toggleApiKey() {
        apiKey = apiKey.toggled
        print("⚠️ Теперь используется \(apiKey.description) ключ")
    }
    
    static let shared = NetworkService()
    private init() {}
    
// MARK: - fetchRequest
    private func fetchRequest<T: Decodable>(
        endpoint: String,
        method: RequestMethod,
        encodableData: Encodable? = nil,
        useFallback: Bool = true
    ) async throws -> T {
        // Configure url
        guard let url = URL(string: endpoint + apiKey.rawValue) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add Content-Type header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Configure request body
        if let encodableData {
            do {
                let encodable = AnyEncodable(encodableData)
                request.httpBody = try JSONEncoder().encode(encodable)
            } catch {
                throw NetworkError.encodingError(underline: error)
            }
        }
        
        // Request
        let(data, response) = try await URLSession.shared.data(for: request)
        
        // Answer validation
        //TODO: Add error handling
        guard let httpResponse = response as? HTTPURLResponse else  { throw NetworkError.invalidResponse}
        
        // Use reserve api key if basic reach monthly limit
        if httpResponse.statusCode == 429, useFallback {
            toggleApiKey()
            return try await fetchRequest(
                endpoint: endpoint,
                method: method,
                encodableData: encodableData,
                useFallback: false
            )
        }
        
        // Check and validation response code
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    
        //Final parse and return model
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            throw NetworkError.parsingError(underline: error)
        }
    }
}

// MARK: - NetworkService request functions
extension NetworkService {
    func requestFlightDetail(code: String) async throws -> FlightModel {
        try await fetchRequest(endpoint: Endpoint.flight(code: code), method: .get)
    }
}

