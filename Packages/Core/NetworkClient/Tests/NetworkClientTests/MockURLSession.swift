//
//  MockURLSession.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation
import NetworkClient

public class MockURLSession: URLSessionProtocol {
    
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToThrow: Error?
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = errorToThrow {
            throw error
        }
        
        guard let response = responseToReturn else {
            throw NetworkError.mockFailure("responseToReturn must be set")
        }
        
        let data = dataToReturn ?? Data()
        return (data, response)
    }
}
