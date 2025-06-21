//
//  MockTransactionService.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

/// Mock implementation of the TransactionService protocol.
///
/// Used for previewing without relying on real API calls
public struct MockTransactionService: TransactionService {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Fetch Transaction Method
    
    public func fetchAllTransactions() async throws -> [TransactionItem] {
        guard let url = Bundle.module.url(forResource: "MockTransactions", withExtension: "json") else {
            throw NSError(domain: "Mock", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([TransactionItem].self, from: data)
    }
}
