//
//  TransactionHistoryViewModel.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation
import TransactionHistoryDomain

public final class TransactionHistoryViewModel: TransactionHistoryViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public private(set) var rows: [TransactionRowViewModel] = []
    @Published public private(set) var errorMessage: String?
    
    private let provider: TransactionProviding
    
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
            self.rows = transactions
                .sorted { $0.createdAt > $1.createdAt }
                .map(TransactionRowViewModel.init)
        } catch {
            self.errorMessage = "Failed to load: \(error.localizedDescription)"
        }
    }
}
