//
//  TransactionHistoryView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents
import TransactionHistoryDomain

public struct TransactionHistoryView<ViewModel: TransactionHistoryViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @StateObject private var viewModel: ViewModel
    @State private var selectedTransaction: TransactionItem?
    
    // MARK: - Initializers
    
    public init(
        viewModel: @autoclosure @escaping () -> ViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
            VStack {
                VStack(spacing: .small) {
                    navigationTitle
                    transactionToolbarView
                    
                    if viewModel.rows.isEmpty {
                        ProgressView()
                    } else {
                        transactionListView
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, .large)
        }
        .task {
            await viewModel.load()
        }
        .fullScreenCover(item: $selectedTransaction) { transaction in
            TransactionDetailsView(viewModel: TransactionRowViewModel(transaction: transaction))
        }
    }
}

// MARK: - View Extension

extension TransactionHistoryView {
    
    // MARK: - Navigation Title View
    
    private var navigationTitle: some View {
        VStack {
            Text("Transaction History")
                .font(.Paynext.subheadlineBold)
                .foregroundStyle(Color.Paynext.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Transaction Toolbar View
    
    private var transactionToolbarView: some View {
        VStack(spacing: .medium) {
            HStack {
                CustomSearchBar()
                    .frame(width: 250)
                Button {
                    // Filter transactions
                } label : {
                    Text("Filter")
                        .filledButton(.quartenary)
                }
            }
            Button {
                // sort transactions
            } label : {
                HStack {
                    Text("Sort by Creation Date Newest to Oldest")
                        .font(.Paynext.caption)
                        .foregroundStyle(Color.Paynext.primaryText.opacity(0.5))
                    Image(systemName: "chevron.up.chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .small, height: .small)
                        .foregroundStyle(Color.Paynext.primaryText.opacity(0.5))
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Transaction List View
    
    private var transactionListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.rows) { row in
                    Button {
                        selectedTransaction = row.rawTransaction
                    } label: {
                        TransactionRowView(viewModel: row)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Preview

struct TransactionHistoryView_Preview: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                provider: MockTransactionProvider()
            )
        )
    }
}
