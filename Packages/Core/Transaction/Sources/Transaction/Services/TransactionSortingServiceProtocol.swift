//
//  TransactionSortingServiceProtocol.swift
//  Transaction
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import Foundation

public protocol TransactionSortingServiceProtocol {
    
    func sort(
        _ transactions: [TransactionItem],
        by option: TransactionSortingOption
    ) -> [TransactionItem]
}
