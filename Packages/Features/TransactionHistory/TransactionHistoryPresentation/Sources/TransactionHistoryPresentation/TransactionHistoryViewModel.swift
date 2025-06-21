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
    
    // MARK: - Dependencies
    
    private let service: TransactionService
    private let filterService: TransactionFilterService
    private let sortingService: TransactionSortingServiceProtocol
    
    // MARK: - Internal State
    
    private var allTransactions: [TransactionItem] = []
    private var currentFilter: TransactionFilterCriteria?
    private var currentSorting: TransactionSortingOption = .dateDescending
    
    // MARK: - Initializers
    
    public init(
        service: TransactionService = MockTransactionService(),
        filterService: TransactionFilterService = TransactionFilterService(),
        sortingService: TransactionSortingServiceProtocol = TransactionSortingService()
    ) {
        self.service = service
        self.filterService = filterService
        self.sortingService = sortingService
    }
    
    // MARK: - Data Loading
    
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
    
    // MARK: - Filtering
    
    public func applyFiltersLocally(_ criteria: TransactionFilterCriteria) {
        // store filtering
        self.currentFilter = criteria
        
        let filtered = filterService
            .apply(filters: criteria, to: allTransactions)
        
        applySorting(to: filtered)
    }
    
    // MARK: - Sorting
    
    public func setSortOption(_ option: TransactionSortingOption) {
        currentSorting = option
        sortButtonTitle = option.label
        applyFiltersAndSorting()
    }
    
    private func applySorting(to items: [TransactionItem]) {
        let sorted = sortingService.sort(items, by: currentSorting)
        self.rows = sorted.map(TransactionRowViewModel.init)
    }
    
    private func applyFiltersAndSorting() {
        let filtered = currentFilter.map {
            filterService.apply(filters: $0, to: allTransactions)
        } ?? allTransactions
        
        applySorting(to: filtered)
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
    @Published public var dateDescendingOptionTitle: String = "Date: Newest > Oldest"
    @Published public var dateAscendingOptionTitle: String = "Date: Oldest > Newest"
    @Published public var amountDescendingOptionTitle: String = "Amount: Highest > Lowest"
    @Published public var amountAscendingOptionTitle: String = "Amount: Lowest > Highest"
}
