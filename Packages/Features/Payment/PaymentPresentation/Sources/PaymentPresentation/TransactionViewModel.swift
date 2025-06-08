//
//  TransactionViewModel.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

public class TransactionViewModel: TransactionViewModelProtocol {
    
    // MARK: - Dependencies
    
    @Published public var paymentState: TransactionView.TransactionState
    
    // MARK: - Initializers
    
    public init(
        paymentState: TransactionView.TransactionState
    ) {
        self.paymentState = paymentState
    }
}
