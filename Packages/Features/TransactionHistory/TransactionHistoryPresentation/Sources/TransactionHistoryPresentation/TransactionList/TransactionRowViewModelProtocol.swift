//
//  TransactionRowViewModelProtocol.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import SwiftUI
import TransactionHistoryDomain

public protocol TransactionRowViewModelProtocol: Identifiable, Equatable {
    
    var id: UUID { get }
    var title: String { get }
    var formattedDate: String { get }
    var formattedAmount: String { get }
    var amountColor: Color { get }
    var statusIconName: String { get }
    var statusIconColor: Color { get }
    var rawTransaction: TransactionItem { get }
}
