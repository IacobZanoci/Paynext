//
//  TransactionFilterCriteria.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

public struct TransactionFilterCriteria {
    
    // MARK: - Properties
    
    public let myAccountNumber: String
    public let payeeAccountNumber: String
    public let payeeName: String
    public let transactionStatus: TransactionStatus?
    public let dateRange: ClosedRange<Date>
    public let hideCompleted: Bool
    
    // MARK: - Initializers
    
    public init(
        myAccountNumber: String,
        payeeAccountNumber: String,
        payeeName: String,
        transactionStatus: TransactionStatus?,
        dateRange: ClosedRange<Date>,
        hideCompleted: Bool
    ) {
        self.myAccountNumber = myAccountNumber
        self.payeeAccountNumber = payeeAccountNumber
        self.payeeName = payeeName
        self.transactionStatus = transactionStatus
        self.dateRange = dateRange
        self.hideCompleted = hideCompleted
    }
}
