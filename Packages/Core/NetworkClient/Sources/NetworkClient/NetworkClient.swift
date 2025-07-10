//
//  NetworkClient.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation

public final class NetworkClient: NetworkClientProtocol, @unchecked Sendable {
    
    private let urlSession: URLSessionProtocol
    
    public init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - GET
    
    public func get(from url: URL,
                    headers: [String : String]? = nil,
                    queryItems: [URLQueryItem]? = nil) async throws -> Data
    {
        var request = URLRequest(url: configureQueryParameters(for: url, with: queryItems))
        request.httpMethod = "GET"
        configureHeaders(for: &request, with: headers)
        return try await perform(request)
    }
    
    // MARK: - POST
    
    public func post(to url: URL,
                     body: Encodable,
                     headers: [String: String]? = nil,
                     queryItems: [URLQueryItem]? = nil) async throws -> Data
    {
        var request = URLRequest(url: configureQueryParameters(for: url, with: queryItems))
        request.httpMethod = "POST"
        configureHeaders(for: &request, with: headers)
        request.httpBody = try encodeBody(body)
        return try await perform(request)
    }
    
    // MARK: - PUT
    
    public func put(to url: URL,
                    body: Encodable,
                    headers: [String : String]? = nil,
                    queryItems: [URLQueryItem]? = nil) async throws -> Data
    {
        var request = URLRequest(url: configureQueryParameters(for: url, with: queryItems))
        request.httpMethod = "PUT"
        configureHeaders(for: &request, with: headers)
        request.httpBody = try encodeBody(body)
        return try await perform(request)
    }
    
    // MARK: - DELETE
    
    public func delete(from url: URL,
                       headers: [String : String]? = nil,
                       queryItems: [URLQueryItem]? = nil) async throws -> Data
    {
        var request = URLRequest(url: configureQueryParameters(for: url, with: queryItems))
        request.httpMethod = "DELETE"
        configureHeaders(for: &request, with: headers)
        return try await perform(request)
    }
    
    // MARK: - EncodeBody
    
    private func encodeBody<T: Encodable>(_ body: T) throws -> Data {
        do {
            return try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.encodingError
        }
    }
    
    // MARK: - Perform
    
    private func perform(_ request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            return data
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                throw NetworkError.timeout
            }
            
            if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw NetworkError.requestFailed(error)
        }
    }
    
    // MARK: - Helpers
    
    private func configureHeaders(for request: inout URLRequest, with headers: [String: String]?) {
        
        var headers = headers ?? [:]
        
        if headers["Content-Type"] == nil {
            headers["Content-Type"] = "application/json"
        }
        
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func configureQueryParameters(for url: URL, with queryItems: [URLQueryItem]?) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        return components?.url ?? url
    }
}
