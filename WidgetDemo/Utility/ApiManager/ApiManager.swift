//
//  ApiManager.swift
//  ApiDemoSwiftUI
//
//  Created by Chetan Hedamba on 08/01/25.
//

import Foundation

class APIManager {
    static let shared = APIManager() // Singleton instance
    private init() {} // Private initializer to prevent external instantiation
    
    /// Generic function to make API requests and decode JSON response
    /// - Parameters:
    ///   - url: The URL of the API endpoint
    ///   - method: HTTP method (GET, POST, etc.)
    ///   - parameters: Optional dictionary of parameters for the request body
    ///   - headers: Optional dictionary of HTTP headers
    ///   - completion: Completion handler with decoded data or error
    func request<T: Decodable>(
        url: String,
        method: String = "GET",
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Set headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set request body
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(APIError.invalidParameters))
                return
            }
        }
        
        // Perform network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            // Decode JSON response
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.decodingFailed))
                }
            }
        }.resume()
    }
    
    /// API Error Enum
    enum APIError: Error, LocalizedError {
        case invalidURL
        case invalidParameters
        case noData
        case decodingFailed
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "The URL is invalid."
            case .invalidParameters: return "The parameters are invalid."
            case .noData: return "No data received from the server."
            case .decodingFailed: return "Failed to decode the response."
            }
        }
    }
}
