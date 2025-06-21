//
//  TransactionRowView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import SwiftUI
import UIComponents
import Transaction

public struct TransactionRowView: View {
    
    // MARK: - Dependencies
    
    let viewModel: any TransactionRowViewModelProtocol
    
    // MARK: - Initializers
    
    public init(
        viewModel: some TransactionRowViewModelProtocol
    ) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    public var body: some View {
        TransactionHistoryItemView(
            imageName: viewModel.statusIconName,
            statusIconColor: viewModel.statusIconColor,
            title: viewModel.title,
            date: viewModel.formattedDate,
            amount: viewModel.formattedAmount,
            amountColor: viewModel.amountColor
        )
    }
}

// MARK: - Preview

#Preview {
    let mockTransaction = TransactionItem(
        id: UUID(),
        payeeName: "Iacob Zanoci",
        payeeAccountNumber: "",
        payeeRoutingNumber: "",
        payerName: "",
        payerAccountNumber: "",
        transactionAmount: 300.00,
        transactionDate: "2025-06-11",
        status: "COMPLETED",
        createdAt: "2025-06-10T12:30:00",
        updatedAt: "2025-06-10T12:30:00"
    )
    
    let mockViewModel = TransactionRowViewModel(
        transaction: mockTransaction
    )
    
    TransactionRowView(viewModel: mockViewModel)
        .padding()
}
