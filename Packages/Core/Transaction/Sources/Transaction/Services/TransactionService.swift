//
//  TransactionService.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

@MainActor
public protocol TransactionService {
    
    func fetchAllTransactions() async throws -> [TransactionItem]
}
