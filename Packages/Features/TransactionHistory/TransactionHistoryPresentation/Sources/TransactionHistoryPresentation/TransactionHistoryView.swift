//
//  TransactionHistoryView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents
import Transaction

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
                        if viewModel.errorMessage != nil {
                            Spacer()
                            ProgressView()
                            Spacer()
                        } else {
                            noDataMatchFilterCriteriaView
                        }
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
            TransactionFilterView(
                viewModel: TransactionFilterViewModel(
                    onApply: { criteria in
                        viewModel.applyFiltersLocally(criteria)
                    }
                )
            )
        }
    }
}

// MARK: - View Extension

extension TransactionHistoryView {
    
    // MARK: - Navigation Title View
    
    private var navigationTitle: some View {
        VStack {
            Text(viewModel.transactionNavigationTitle)
                .font(.Paynext.subheadline.weight(.bold))
                .foregroundStyle(Color.Paynext.primary)
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
                        .primary()
                }
            }
            Menu {
                Button(viewModel.dateDescendingOptionTitle) {
                    viewModel.setSortOption(.dateDescending)
                }
                Button(viewModel.dateAscendingOptionTitle) {
                    viewModel.setSortOption(.dateAscending)
                }
                Button(viewModel.amountDescendingOptionTitle) {
                    viewModel.setSortOption(.amountDescending)
                }
                Button(viewModel.amountAscendingOptionTitle) {
                    viewModel.setSortOption(.amountAscending)
                }
            } label : {
                HStack {
                    Text(viewModel.sortButtonTitle)
                        .font(.Paynext.footnote)
                        .foregroundStyle(Color.Paynext.secondary)
                    Image(systemName: viewModel.sortButtonImageTitle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .small, height: .small)
                        .foregroundStyle(Color.Paynext.secondary)
                    Spacer()
                }
                .padding(.bottom, .small)
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
                            .onAppear {
                                Task {
                                    await viewModel.loadNextPageIfNeeded(currentItem: row)
                                }
                            }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var noDataMatchFilterCriteriaView: some View {
        VStack(spacing: .medium) {
            Spacer()
            Image(systemName: viewModel.noTransactionsImageTitle)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.Paynext.primary)
                .frame(width: 120, height: 80)
            Text(viewModel.noTransactionsTitle)
                .font(.Paynext.headline.weight(.bold))
                .foregroundStyle(Color.Paynext.primary)
            Text(viewModel.noDataMatchFilterCriteriaMessage)
                .multilineTextAlignment(.center)
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.secondary)
                .padding(.bottom, 180)
            Spacer()
        }
    }
}

// MARK: - Preview

struct TransactionHistoryView_Preview: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: MockTransactionService()
            )
        )
    }
}
