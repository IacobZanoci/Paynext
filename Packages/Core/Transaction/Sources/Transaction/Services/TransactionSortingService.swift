//
//  TransactionSortingService.swift
//  Transaction
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import Foundation

public struct TransactionSortingService: TransactionSortingServiceProtocol {
    
    //MARK: - Initializers
    
    public init() {}
    
    //MARK: - Methods
    
    public func sort(
        _ transactions: [TransactionItem],
        by option: TransactionSortingOption
    ) -> [TransactionItem] {
        
        switch option {
        case .dateDescending:
            return transactions.sorted { $0.createdAtDate > $1.createdAtDate }
        case .dateAscending:
            return transactions.sorted { $0.createdAtDate < $1.createdAtDate }
        case .amountDescending:
            return transactions.sorted { $0.transactionAmount > $1.transactionAmount }
        case .amountAscending:
            return transactions.sorted { $0.transactionAmount < $1.transactionAmount }
        }
    }
}
