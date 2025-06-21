//
//  TransactionSortingOption.swift
//  Transaction
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import Foundation

public enum TransactionSortingOption: CaseIterable, Equatable {
    
    case dateDescending
    case dateAscending
    case amountDescending
    case amountAscending
    
    public var label: String {
        switch self {
        case .dateDescending:
            return "Transaction Date (Newest > Oldest)"
        case .dateAscending:
            return "Transaction Date (Oldest > Newest)"
        case .amountDescending:
            return "Amount (Highest > Lowest)"
        case .amountAscending:
            return "Amount (Lowest > Highest)"
        }
    }
}
