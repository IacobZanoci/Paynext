//
//  DashboardViewModel.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation
import LoginDomain
import Persistance
import TransactionHistoryPresentation
import TransactionHistoryDomain

public final class DashboardViewModel: DashboardViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let provider: TransactionProviding
    
    // MARK: - Properties
    
    @Published public private(set) var recentTransactions: [TransactionRowViewModel] = []
    @Published public var username: String = ""
    @Published public var actions: [ConfirmationAction] = ConfirmationAction.allCases
    
    // MARK: - Titles
    
    @Published public var appDescriptionText: String = ("""
                                                        Paynext makes
                                                        sending money fast,
                                                        secure, and effortless - 
                                                        whether it's across the street
                                                        or across the world.
                                                        """)
    @Published public var dashboardTitle: String = "Welcome back!"
    @Published public var welcomeImageTitle: String = "welcomeImage"
    @Published public var dashboardCardImageTitle: String = "dashboardCardImage"
    @Published public var dashboardCardHideButtonTitle: String = "xmark"
    @Published public var transactionsSectionTitle: String = "Transaction History"
    @Published public var transactionsSectionButtonTitle: String = "See all"
    @Published public var transactionsSectionButtonImageTitle: String = "chevron.right"
    
    // MARK: - Initializers
    
    public init(
        provider: TransactionProviding
    ) {
        self.provider = provider
    }
    
    // MARK: - Methods
    
    public func load() async {
        do {
            let transactions = try await provider.fetchTransactions()
            let sorted = Array(transactions.sorted { $0.createdAt > $1.createdAt }.prefix(3))
            self.recentTransactions = sorted.map { TransactionRowViewModel(transaction: $0) }
        } catch {
            print("Failed to fetch recent transactions: \(error)")
        }
    }
    
    public func fetchUsername() {
        if let user: LoginDomain.PaynextUser = UserDefaultsManager.shared.get(forKey: .paynextUser) {
            username = user.userName
        }
    }
}
