//
//  TransactionItem.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

public struct TransactionItem: Identifiable, Codable, Equatable, Sendable {
    
    // MARK: - Properties
    
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
    
    // MARK: - Initializers
    
    public init(
        id: UUID,
        payeeName: String,
        payeeAccountNumber: String,
        payeeRoutingNumber: String,
        payerName: String,
        payerAccountNumber: String,
        transactionAmount: Double,
        transactionDate: String,
        status: String,
        createdAt: String,
        updatedAt: String
    ) {
        self.id = id
        self.payeeName = payeeName
        self.payeeAccountNumber = payeeAccountNumber
        self.payeeRoutingNumber = payeeRoutingNumber
        self.payerName = payerName
        self.payerAccountNumber = payerAccountNumber
        self.transactionAmount = transactionAmount
        self.transactionDate = transactionDate
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // MARK: - Date Conversion
    
    public var createdAtDate: Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: createdAt) ?? Date.distantPast
    }
}
