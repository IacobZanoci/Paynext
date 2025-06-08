//
//  PaymentViewModel.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation
import CredentialsValidator

public final class PaymentViewModel: PaymentViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let credentialsValidator: CredentialsValidatorProtocol
    
    // MARK: - TextFields
    
    @Published public var accountNumberTextField: String = "Payee Account Number"
    @Published public var routingNumberTextField: String = "Payee Routing Number"
    @Published public var payeeNameTextField: String = "Payee Name / Surname"
    @Published public var amountTextField: String = "Amount"
    
    // MARK: - Placeholders
    
    @Published public var accountNumberPlaceholder: String = "Enter account number"
    @Published public var routingNumberPlaceholder: String = "Enter routing number"
    @Published public var payeeNamePlaceholder: String = "Enter payee name"
    @Published public var amountPlaceholder: String = "0.00"
    
    // MARK: - Properties
    
    @Published public var isStartProceedingDisabled: Bool = true
    @Published public var nameValidationState: Bool = true
    @Published public var accountNumberValidationState: Bool = true
    @Published public var routingNumberValidationState: Bool = true
    @Published public var amountValidationState: Bool = true
    @Published public var paymentState: TransactionView.TransactionState? = nil
    @Published public var startTime: Date? = nil
    public var isFormatting = false
    
    @Published public var amountRaw: String = "" {
        didSet {
            guard !isFormatting else { return }
            isFormatting = true
            defer { isFormatting = false }
            
            let parsedInput = amountRaw.replacingOccurrences(of: ",", with: "")
            if parsedInput.isEmpty {
                amount = ""
            } else if let value = Double(parsedInput) {
                amount = String(value)
                amountRaw = currencyFormatter.string(from: NSNumber(value: value)) ?? ""
            } else {
                amountRaw = oldValue
            }
        }
    }
    
    @Published public var name: String = "" {
        didSet {
            validateName()
            updateStartProceedingButtonState()
        }
    }
    
    @Published public var accountNumber: String = "" {
        didSet {
            validateAccountNumber()
            updateStartProceedingButtonState()
        }
    }
    
    @Published public var routingNumber: String = "" {
        didSet {
            validateRoutingNumber()
            updateStartProceedingButtonState()
        }
    }
    
    @Published public var amount: String = "" {
        didSet {
            validateAmount()
            updateStartProceedingButtonState()
        }
    }
    
    // MARK: - Initializers
    
    public init(
        credentialsValidator: CredentialsValidatorProtocol
    ) {
        self.credentialsValidator = credentialsValidator
    }
    
    // MARK: - Methods
    
    private func validateName() {
        if name.isEmpty || credentialsValidator.isNameValid(name) {
            nameValidationState = true
        } else {
            nameValidationState = false
        }
    }
    
    private func validateAccountNumber() {
        if accountNumber.isEmpty || credentialsValidator.isAccountNumberValid(accountNumber) {
            accountNumberValidationState = true
        } else {
            accountNumberValidationState = false
        }
    }
    
    private func validateRoutingNumber() {
        if routingNumber.isEmpty || credentialsValidator.isRoutingNumberValid(routingNumber) {
            routingNumberValidationState = true
        } else {
            routingNumberValidationState = false
        }
    }
    
    private func validateAmount() {
        if amount.isEmpty || credentialsValidator.isAmountValid(amount) {
            amountValidationState = true
        } else {
            amountValidationState = false
        }
    }
    
    private func updateStartProceedingButtonState() {
        if credentialsValidator.isNameValid(name) &&
            credentialsValidator.isAccountNumberValid(accountNumber) &&
            credentialsValidator.isRoutingNumberValid(routingNumber) &&
            credentialsValidator.isAmountValid(amount)
        {
            isStartProceedingDisabled = false
        } else {
            isStartProceedingDisabled = true
        }
    }
    
    // MARK: - Events
    
    @MainActor
    public func onStartProceeding() async {
        startTime = Date()
        self.paymentState = .loading
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        if let amountValue = Double(amount), amountValue > 0 {
            self.paymentState = .successfully
        } else {
            self.paymentState = .failed
        }
    }
    
    // MARK: - Formatter
    
    public func formattedStartTime() -> String {
        guard let startTime = startTime else { return "Not started yet" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: startTime)
    }
    
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
