//
//  TransactionProviding.swift
//  TransactionHistoryDomain
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation

@MainActor
public protocol TransactionProviding {
    
    func fetchTransactions() async throws -> [TransactionItem]
}
