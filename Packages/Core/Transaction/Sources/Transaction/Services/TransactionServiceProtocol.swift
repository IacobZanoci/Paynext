//
//  TransactionServiceProtocol.swift
//  Transaction
//
//  Created by Iacob Zanoci on 09.07.2025.
//

import Foundation

@MainActor
public protocol TransactionServiceProtocol {
    
    func fetchAllTransactions(page: Int?, pageSize: Int?) async throws -> [TransactionItem]
}
