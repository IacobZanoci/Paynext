//
//  URLSessionProtocol.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
