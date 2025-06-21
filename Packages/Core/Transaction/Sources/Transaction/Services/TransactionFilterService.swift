//
//  TransactionFilterService.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

public struct TransactionFilterService {
    
    // MARK: - Initializers
    
    public init () {}
    
    // MARK: - Methods
    
    public func apply(
        filters: TransactionFilterCriteria,
        to items: [TransactionItem]
    ) -> [TransactionItem] {
        
        items.filter { tx in
            let matchesMyAccount = filters.myAccountNumber.isEmpty || tx.payerAccountNumber.contains(filters.myAccountNumber)
            let matchesPayeeAccount = filters.payeeAccountNumber.isEmpty || tx.payeeAccountNumber.contains(filters.payeeAccountNumber)
            let matchesPayeeName = filters.payeeName.isEmpty || tx.payeeName.localizedCaseInsensitiveContains(filters.payeeName)
            let matchesStatus = filters.transactionStatus.map { tx.status == $0.rawValue } ?? true
            let matchesDate = filters.dateRange.contains(tx.createdAtDate)
            let matchesCompleted = !filters.hideCompleted || tx.status != "COMPLETED"
            
            return matchesMyAccount &&
            matchesPayeeAccount &&
            matchesPayeeName &&
            matchesStatus &&
            matchesDate &&
            matchesCompleted
        }
    }
}
