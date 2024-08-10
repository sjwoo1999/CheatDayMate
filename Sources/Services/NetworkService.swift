//
//  NetworkService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class NetworkService {
    func request<T: Decodable>(_ endpoint: String, method: String = "GET") async throws -> T {
        guard let url = URL(string: "https://api.example.com/\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
