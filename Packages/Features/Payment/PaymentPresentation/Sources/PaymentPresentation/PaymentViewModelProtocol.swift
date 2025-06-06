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
    var payeeName: String { get set }
    var amount: Double? { get set }
    var amountRaw: String { get set }
    var isFormatting: Bool { get set }
    
    // MARK: - Placeholders
    
    var accountNumberPlaceholder: String { get }
    var routingNumberPlaceholder: String { get }
    var payeeNamePlaceholder: String { get }
    var amountPlaceholder: String { get }
    
    // MARK: - Formatter
    
    var currencyFormatter: NumberFormatter { get }
}
