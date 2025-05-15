//
//  NetworkClientProtocol.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation

public protocol NetworkClientProtocol {
    
    /// Performs a GET request with optional headers and query parameters.
    func get(
        from url: URL,
        headers: [String: String]?,
        queryItems: [URLQueryItem]?) async throws -> Data
    
    /// Performs a POST request with an encodable body, headers, and query parameters.
    func post(
        to url: URL,
        body: Encodable,
        headers: [String: String]?,
        queryItems: [URLQueryItem]?) async throws -> Data
    
    /// Performs a PUT request with an encodable body, headers, and query parameters.
    func put(
        to url: URL,
        body: Encodable,
        headers: [String: String]?,
        queryItems: [URLQueryItem]?) async throws -> Data
    
    /// Performs a DELETE request with optional headers and query parameters.
    func delete(
        from url: URL,
        headers: [String: String]?,
        queryItems: [URLQueryItem]?) async throws -> Data
}
