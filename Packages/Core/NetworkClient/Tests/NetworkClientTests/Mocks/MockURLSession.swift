//
//  MockURLSession.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 15.05.2025.
//

import Foundation
import NetworkClient

public class MockURLSession: URLSessionProtocol {
    
    public var result: Result<(Data, URLResponse), Error> = .failure(
        NetworkError.requestFailed(NSError(domain: "Mock", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result set"]))
    )
    
    public init() {}
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try result.get()
    }
}
