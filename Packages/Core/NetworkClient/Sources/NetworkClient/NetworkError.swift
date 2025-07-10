//
//  NetworkError.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidResponse
    case requestFailed(Error)
    case timeout
    case decodingFailed
    case encodingError
    case httpError(statusCode: Int)
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidResponse, .invalidResponse),
            (.timeout, .timeout),
            (.decodingFailed, .decodingFailed),
            (.encodingError, .encodingError):
            return true
        case let (.httpError(code1), .httpError(code2)):
            return code1 == code2
        case (.requestFailed, .requestFailed):
            return true
        default:
            return false
        }
    }
}
