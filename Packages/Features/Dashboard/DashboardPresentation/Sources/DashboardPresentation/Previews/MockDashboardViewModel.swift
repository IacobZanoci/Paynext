//
//  MockDashboardViewModel.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation
import TransactionHistoryPresentation

final class MockDashboardViewModel: DashboardViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    @Published var recentTransactions: [TransactionRowViewModel] = []
    @Published var username: String = "Iacob"
    @Published var actions: [ConfirmationAction] = ConfirmationAction.allCases
    
    // MARK: Titles
    
    @Published var appDescriptionText: String = ("""
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
    
    // MARK: - Methods
    
    func load() async {}
    func fetchUsername() { }
}
