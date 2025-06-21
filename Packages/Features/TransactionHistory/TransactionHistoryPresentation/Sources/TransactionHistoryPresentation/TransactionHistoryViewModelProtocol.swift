//
//  TransactionHistoryViewModelProtocol.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation
import Transaction

@MainActor
public protocol TransactionHistoryViewModelProtocol: ObservableObject {
    
    // MARK: - Data
    
    var rows: [TransactionRowViewModel] { get }
    var errorMessage: String? { get }
    
    // MARK: - Titles
    
    var transactionNavigationTitle: String { get }
    var filterButtonTitle: String { get }
    var sortButtonTitle: String { get }
    var sortButtonImageTitle: String { get }
    var errorFetchTransactionMessage: String { get }
    var noDataMatchFilterCriteriaMessage: String { get }
    var noTransactionsImageTitle: String { get }
    var noTransactionsTitle: String { get }
    var dateDescendingOptionTitle: String { get }
    var dateAscendingOptionTitle: String { get }
    var amountDescendingOptionTitle: String { get }
    var amountAscendingOptionTitle: String { get }
    
    // MARK: - Actions
    
    func load() async
    func applyFiltersLocally(_ criteria: TransactionFilterCriteria)
    func setSortOption(_ option: TransactionSortingOption)
}
