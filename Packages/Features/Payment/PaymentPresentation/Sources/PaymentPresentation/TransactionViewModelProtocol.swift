//
//  TransactionViewModelProtocol.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

@MainActor
public protocol TransactionViewModelProtocol: ObservableObject {
    
    // MARK: - Dependencies
    
    var paymentState: TransactionView.TransactionState { get set }
}
