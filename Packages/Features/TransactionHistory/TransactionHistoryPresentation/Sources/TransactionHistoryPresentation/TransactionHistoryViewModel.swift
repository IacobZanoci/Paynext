//
//  TransactionHistoryViewModel.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation
import Transaction

@MainActor
public final class TransactionHistoryViewModel: TransactionHistoryViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public private(set) var rows: [TransactionRowViewModel] = []
    @Published public private(set) var errorMessage: String?
    
    private let service: TransactionService
    private let filterService = TransactionFilterService()
    private var allTransactions: [TransactionItem] = []
    
    // MARK: - Initializers
    
    public init(
        service: TransactionService = MockTransactionService()
    ) {
        self.service = service
    }
    
    // MARK: - Methods
    
    public func load() async {
        do {
            let transactions = try await service.fetchAllTransactions()
            self.allTransactions = transactions
            self.rows = transactions
                .sorted { $0.createdAt > $1.createdAt }
                .map(TransactionRowViewModel.init)
        } catch {
            self.errorMessage = "Failed to load: \(error.localizedDescription)"
        }
    }
    
    public func applyFiltersLocally(_ criteria: TransactionFilterCriteria) {
        let filtered = filterService
            .apply(filters: criteria, to: allTransactions)
            .sorted { $0.createdAt > $1.createdAt }
            .map(TransactionRowViewModel.init)
        self.rows = filtered
    }
    
    // MARK: - Titles
    
    @Published public var transactionNavigationTitle: String = "Transaction History"
    @Published public var filterButtonTitle: String = "Filter"
    @Published public var sortButtonTitle: String = "Sort by Creation Date Newest to Oldest"
    @Published public var sortButtonImageTitle: String = "chevron.up.chevron.down"
    @Published public var errorFetchTransactionMessage: String = "Failed to load transactions."
    @Published public var noDataMatchFilterCriteriaMessage: String = "No data matches the filtered criteria.\nPlease adjust the filters or reset them."
    @Published public var noTransactionsImageTitle: String = "text.page.badge.magnifyingglass"
    @Published public var noTransactionsTitle: String = "No Transactions"
}
