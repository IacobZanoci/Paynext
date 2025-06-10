//
//  TransactionItem.swift
//  TransactionHistoryDomain
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation

public struct TransactionItem: Identifiable, Codable, Equatable {
    
    public let id: UUID
    public let payeeName: String
    public let payeeAccountNumber: String
    public let payeeRoutingNumber: String
    public let payerName: String
    public let payerAccountNumber: String
    public let transactionAmount: Double
    public let transactionDate: String
    public let status: String
    public let createdAt: String
    public let updatedAt: String
}
