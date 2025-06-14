//
//  DashboardViewModelProtocol.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation
import TransactionHistoryPresentation

@MainActor
public protocol DashboardViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var recentTransactions: [TransactionRowViewModel] { get }
    var username: String { get set }
    var actions: [ConfirmationAction] { get }
    
    // MARK: - Titles
    
    var appDescriptionText: String { get }
    var dashboardTitle: String { get }
    var welcomeImageTitle: String { get }
    var dashboardCardImageTitle: String { get }
    var dashboardCardHideButtonTitle: String { get }
    var transactionsSectionTitle: String { get }
    var transactionsSectionButtonTitle: String { get }
    var transactionsSectionButtonImageTitle: String { get }
    
    // MARK: - Methods
    
    func load() async
    func fetchUsername()
}
