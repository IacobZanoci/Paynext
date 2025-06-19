//
//  TransactionHistoryViewModel.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation
import Transaction

public final class TransactionHistoryViewModel: TransactionHistoryViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public private(set) var rows: [TransactionRowViewModel] = []
    @Published public private(set) var errorMessage: String?
    
    private let service: TransactionService
    
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
            self.rows = transactions
                .sorted { $0.createdAt > $1.createdAt }
                .map(TransactionRowViewModel.init)
        } catch {
            self.errorMessage = "Failed to load: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Titles
    
    @Published public var transactionNavigationTitle: String = "Transaction History"
    @Published public var filterButtonTitle: String = "Filter"
    @Published public var sortButtonTitle: String = "Sort by Creation Date Newest to Oldest"
    @Published public var sortButtonImageTitle: String = "chevron.up.chevron.down"
}
