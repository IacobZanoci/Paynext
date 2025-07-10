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
public struct MockTransactionService: TransactionServiceProtocol {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Fetch Transaction Method
    
    public func fetchAllTransactions(page: Int?, pageSize: Int?) async throws -> [TransactionItem] {
        guard let url = Bundle.module.url(forResource: "MockTransactions", withExtension: "json") else {
            throw NSError(domain: "Mock", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found"])
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let allTransactions = try decoder.decode([TransactionItem].self, from: data)
        
        // Pagination Simulation for Mock Transactions
        guard let page = page, let pageSize = pageSize else {
            return allTransactions
        }
        
        let start = (page - 1) * pageSize
        let end = min(start + pageSize, allTransactions.count)
        
        if start < allTransactions.count {
            let sliced = Array(allTransactions[start..<end])
            return sliced
        } else {
            return []
        }
    }
}
