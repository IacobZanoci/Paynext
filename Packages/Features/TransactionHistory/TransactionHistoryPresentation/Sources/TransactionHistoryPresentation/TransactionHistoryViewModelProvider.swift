//
//  TransactionHistoryViewModelProvider.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 09.07.2025.
//

import Foundation
import Combine
import Transaction
import NetworkClient
import SettingsPresentation

@MainActor
public final class TransactionHistoryViewModelProvider: ObservableObject {
    
    // MARK: - Dependencies
    
    @Published public private(set) var viewModel: TransactionHistoryViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    public init(
        settings: SettingsViewModel
    ) {
        self.viewModel = Self.makeViewModel(remote: settings.isRemoteSourceEnabled)
        
        // Observe published property (Combine)
        settings.$isRemoteSourceEnabled
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.viewModel = Self.makeViewModel(remote: newValue)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Methods
    
    private static func makeViewModel(remote: Bool) -> TransactionHistoryViewModel {
        let service: TransactionServiceProtocol = remote
        ? TransactionService(networkClient: NetworkClient())
        : MockTransactionService()
        
        let viewModel = TransactionHistoryViewModel(service: service)
        
        Task { @MainActor in
            await viewModel.load()
        }
        
        return viewModel
    }
}
