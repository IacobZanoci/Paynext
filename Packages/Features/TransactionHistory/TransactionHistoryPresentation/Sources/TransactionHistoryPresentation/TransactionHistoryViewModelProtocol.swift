//
//  TransactionHistoryViewModelProtocol.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import Foundation

@MainActor
public protocol TransactionHistoryViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var rows: [TransactionRowViewModel] { get }
    var errorMessage: String? { get }
    
    // MARK: - Methods
    
    func load() async
}
