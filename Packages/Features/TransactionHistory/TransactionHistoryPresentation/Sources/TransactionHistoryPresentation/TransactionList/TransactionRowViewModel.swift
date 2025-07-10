//
//  TransactionRowViewModel.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation
import SwiftUI
import DesignSystem
import Transaction

public struct TransactionRowViewModel: TransactionRowViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let transaction: TransactionItem
    
    // MARK: - Initializers
    
    public init(
        transaction: TransactionItem
    ) {
        self.transaction = transaction
    }
    
    // MARK: - Properties
    
    public var id: String {
        "\(transaction.id.uuidString)-\(transaction.createdAt)"
    }
    
    public var title: String { transaction.payeeName }
    
    public var formattedDate: String {
        let input = DateFormatter()
        input.locale = Locale(identifier: "en_US_POSIX")
        input.timeZone = TimeZone(secondsFromGMT: 0)
        input.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = input.date(from: transaction.createdAt) {
            let output = DateFormatter()
            output.locale = Locale.current
            output.dateFormat = "HH:mm dd/MM/yy"
            return output.string(from: date)
        } else {
            return transaction.createdAt
        }
    }
    
    
    public var formattedAmount: String {
        let amount = String(format: "%.2f", abs(transaction.transactionAmount))
        return "$\(amount)"
    }
    
    public var amountColor: Color {
        .Paynext.incomeText
    }
    
    public var statusIconName: String {
        switch transaction.status {
        case "COMPLETED":
            return "checkmark.circle"
        case "PROCESSING":
            return "clock"
        case "FAILED":
            return "x.circle"
        case "REJECTED":
            return "exclamationmark.circle"
        default:
            return "clock"
        }
    }
    
    public var statusIconColor: Color {
        switch transaction.status {
        case "COMPLETED":
            return .Paynext.incomeText
        case "PROCESSING":
            return .orange
        case "FAILED", "REJECTED":
            return .red
        default:
            return .gray
        }
    }
    
    public var rawTransaction: TransactionItem {
        transaction
    }
    
    public static func == (lhs: TransactionRowViewModel, rhs: TransactionRowViewModel) -> Bool {
        lhs.transaction == rhs.transaction
    }
    
    // MARK: - Titles
    
    public var detailsSheetTitle: String = "Transaction Details"
    public var dismissButtonTitle: String = "xmark"
    public var detailsPayeeNameSurnameTitle: String = "Payee Name/Surname"
    public var detailsSourceAccountTitle: String = "Source Account"
    public var detailsPayeeAccountNumberTitle: String = "Payee Account Number"
    public var detailsPayeeRoutingNumberTitle: String = "Payee Routing Number"
    public var detailsDateTimeTitle: String = "Creation Date/Time"
    public var detailsStatusTitle: String = "Status"
    public var detailsAmountTitle: String = "Amount"
}
