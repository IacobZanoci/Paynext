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
    @State private var isFilterPresented: Bool = false
    
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
        .sheet(isPresented: $isFilterPresented) {
            TransactionFilterView(viewModel: TransactionFilterViewModel())
        }
    }
}

// MARK: - View Extension

extension TransactionHistoryView {
    
    // MARK: - Navigation Title View
    
    private var navigationTitle: some View {
        VStack {
            Text(viewModel.transactionNavigationTitle)
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
                    isFilterPresented = true
                } label : {
                    Text(viewModel.filterButtonTitle)
                        .filledButton(.quartenary)
                }
            }
            Button {
                // TODO: Implement transaction sorting logic
            } label : {
                HStack {
                    Text(viewModel.sortButtonTitle)
                        .font(.Paynext.caption)
                        .foregroundStyle(Color.Paynext.primaryText.opacity(0.5))
                    Image(systemName: viewModel.sortButtonImageTitle)
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
