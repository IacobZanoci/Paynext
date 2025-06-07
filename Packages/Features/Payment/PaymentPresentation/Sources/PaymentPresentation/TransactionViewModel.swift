//
//  TransactionViewModel.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import Foundation

public class TransactionViewModel: TransactionViewModelProtocol {
    
    // MARK: - Properties
    
    public var goToHomeAction: () async -> Void
    public var goToPaymentAction: () async -> Void
    public var goToDashboardAction: () async -> Void
    @Published public var paymentState: TransactionView.TransactionState = .loading
    private let amount: Double
    
    // MARK: - Initializers
    
    public init(
        amount: Double,
        goToHome: @escaping () async -> Void,
        goToPayment: @escaping () async -> Void,
        goToDashboard: @escaping () async -> Void
    ) {
        self.amount = amount
        self.goToHomeAction = goToHome
        self.goToPaymentAction = goToPayment
        self.goToDashboardAction = goToDashboard
        Task {
            await showResultAfterDelay()
        }
    }
    
    // MARK: - Methods
    
    private func showResultAfterDelay() async {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        paymentState = amount > 0 ? .successfully : .failed
    }
    
    public func goToHome() async {
        print("goToHome pressed")
        await goToHomeAction()
    }
    
    public func goToPayment() async {
        print("goToPayment pressed")
        await goToPaymentAction()
    }
    
    public func goToDashboard() async {
        print("goToDashboard pressed")
        await goToDashboardAction()
    }
}
