//
//  PaymentViewModelProtocol.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

public protocol PaymentViewModelProtocol: ObservableObject {
    
    // MARK: - TextFields
    
    var accountNumberTextField: String { get }
    var routingNumberTextField: String { get }
    var payeeNameTextField: String { get }
    var amountTextField: String { get }
    
    // MARK: - Properties
    
    var accountNumber: String { get set }
    var routingNumber: String { get set }
    var name: String { get set }
    var amount: String { get set }
    var nameValidationState: Bool { get set }
    var accountNumberValidationState: Bool { get set }
    var routingNumberValidationState: Bool { get set }
    var amountValidationState: Bool { get set }
    var isStartProceedingDisabled: Bool { get set }
    var startTime: Date? { get set }
    var paymentState: TransactionView.TransactionState? { get set }
    
    // MARK: - Placeholders
    
    var accountNumberPlaceholder: String { get }
    var routingNumberPlaceholder: String { get }
    var payeeNamePlaceholder: String { get }
    var amountPlaceholder: String { get }
    
    // MARK: - Formatter
    
    var currencyFormatter: NumberFormatter { get }
    
    // MARK: - Methods
    
    func onStartProceeding() async
}
