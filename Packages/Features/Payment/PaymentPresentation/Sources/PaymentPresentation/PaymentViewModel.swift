//
//  PaymentViewModel.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

public final class PaymentViewModel: PaymentViewModelProtocol {
    
    // MARK: - TextFields
    
    @Published public var accountNumberTextField: String = "Payee Account Number"
    @Published public var routingNumberTextField: String = "Payee Routing Number"
    @Published public var payeeNameTextField: String = "Payee Name / Surname"
    @Published public var amountTextField: String = "Amount"
    
    // MARK: - Properties
    
    @Published public var accountNumber: String = ""
    @Published public var routingNumber: String = ""
    @Published public var payeeName: String = ""
    @Published public var amount: Double? = nil
    
    @Published public var amountRaw: String = "" {
        didSet {
            guard !isFormatting else { return }
            isFormatting = true
            defer { isFormatting = false }
            
            let parsedInput = amountRaw.replacingOccurrences(of: ",", with: "")
            if parsedInput.isEmpty {
                amount = nil
            } else if let value = Double(parsedInput) {
                amount = value
                amountRaw = currencyFormatter.string(from: NSNumber(value: value)) ?? ""
            } else {
                amountRaw = oldValue
            }
        }
    }
    
    public var isFormatting = false
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Placeholders
    
    @Published public var accountNumberPlaceholder: String = "Enter account number"
    @Published public var routingNumberPlaceholder: String = "Enter routing number"
    @Published public var payeeNamePlaceholder: String = "Enter payee name"
    @Published public var amountPlaceholder: String = "0.00"
    
    // MARK: - Formatter
    
    public var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter
    }()
}
