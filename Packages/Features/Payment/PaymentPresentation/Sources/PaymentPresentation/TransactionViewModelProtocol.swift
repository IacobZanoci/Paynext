//
//  TransactionViewModelProtocol.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

@MainActor
public protocol TransactionViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var goToHomeAction: () async -> Void { get }
    var goToPaymentAction: () async -> Void { get }
    var goToDashboardAction: () async -> Void { get }
    var paymentState: TransactionView.TransactionState { get set }
    
    // MARK: - Methods
    
    func goToHome() async
    func goToPayment() async
    func goToDashboard() async
}
