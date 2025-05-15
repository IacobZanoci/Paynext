//
//  NetworkError.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case timeout
    case decodingFailed
    case encodingError
    case httpError(statusCode: Int)
    case mockFailure(String)
}
