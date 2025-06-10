//
//  MockTransactionProvider.swift
//  TransactionHistoryDomain
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation

/// Mock implementation of the TransactionProviding protocol.
///
/// Used for previewing without relying on real API calls
public struct MockTransactionProvider: TransactionProviding {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Fetch Transaction Method
    
    public func fetchTransactions() async throws -> [TransactionItem] {
        guard let url = Bundle.module.url(forResource: "MockTransactions", withExtension: "json") else {
            throw NSError(domain: "MockTransactionProvider", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing MockTransactions.json"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([TransactionItem].self, from: data)
    }
}
