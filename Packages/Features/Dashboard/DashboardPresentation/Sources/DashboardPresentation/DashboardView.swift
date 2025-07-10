//
//  DashboardView.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import SwiftUI
import DesignSystem
import TransactionHistoryPresentation
import Transaction

public struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Properties
    
    private let onSeeAllTap: () -> Void
    private let onTransferTap: () -> Void
    
    // MARK: - Initializers
    
    public init(
        viewModel: @autoclosure @escaping () -> ViewModel,
        onSeeAllTap: @escaping () -> Void = {},
        onTransferTap: @escaping () -> Void = {}
    ) {
        _viewModel = StateObject(wrappedValue: viewModel())
        self.onSeeAllTap = onSeeAllTap
        self.onTransferTap = onTransferTap
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: .extraLarge) {
                    dashboard
                    
                    VStack {
                        transactionHistory
                    }
                    .padding(.horizontal, .large)
                }
                .padding(.bottom, .medium)
            }
            .ignoresSafeArea(.container, edges: .top)
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - View Extension

extension DashboardView {
    
    private var dashboard: some View {
        VStack {
            VStack(spacing: .small) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.dashboardTitle)
                            .font(.Paynext.title.weight(.bold))
                            .foregroundStyle(Color.white)
                            .padding(.vertical, .small)
                        Text(viewModel.username)
                            .font(.Paynext.navigationTitle.weight(.medium))
                            .foregroundStyle(Color.white.opacity(0.9))
                            .onAppear {
                                viewModel.fetchUsername()
                            }
                    }
                    Spacer()
                }
                .padding(.large)
                Image(viewModel.welcomeImageTitle, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, .extraLarge)
            }
            .padding(.top, 40)
            .frame(maxWidth: .infinity)
            .background(Color.Paynext.accent)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .large) {
                    ForEach(viewModel.actions, id: \.self) { action in
                        circleButton(
                            icon: action.icon,
                            title: action.title,
                            titleFont: action.titleFont,
                            iconColor: action.iconColor,
                            backgroundColor: action.backgroundColor,
                            action: action.handler(onTransferTap: onTransferTap)
                        )
                    }
                }
                .padding(.leading, .large)
                .padding(.vertical)
            }
            ZStack(alignment: .topTrailing) {
                HStack(spacing: .medium) {
                    VStack(alignment: .leading, spacing: .small) {
                        Text(viewModel.appDescriptionText)
                            .font(.Paynext.footnote)
                            .foregroundStyle(Color.white)
                            .lineSpacing(.extraSmall)
                            .padding(.top, -.medium)
                    }
                    .multilineTextAlignment(.leading)
                    .layoutPriority(1)
                    
                    Image(viewModel.dashboardCardImageTitle, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.white)
                        .padding(.bottom, -60)
                }
                .padding()
                .frame(minHeight: 150)
                .background(Color.Paynext.contrast)
                .cornerRadius(.large)
                
                Button(action: {}) {
                    Image(systemName: viewModel.dashboardCardHideButtonTitle)
                        .resizable()
                        .frame(width: .small, height: .small)
                        .foregroundStyle(Color.white)
                        .padding(.medium)
                }
            }
            .padding(.horizontal, .large)
        }
    }
    
    // Custom Circle Button
    func circleButton(
        icon: String,
        title: String,
        titleFont: Font,
        iconColor: Color,
        backgroundColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        VStack(spacing: .small) {
            Button(action: {
                action()
            }) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width:52, height: 52)
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(iconColor)
                }
            }
            Text(title)
                .font(titleFont)
                .foregroundStyle(Color.Paynext.primary)
        }
    }
    
    // Transaction History
    private var transactionHistory: some View {
        VStack {
            HStack {
                Text(viewModel.transactionsSectionTitle)
                    .font(.Paynext.subheadline.weight(.medium))
                    .foregroundStyle(Color.Paynext.primary)
                Spacer()
                Button {
                    onSeeAllTap()
                } label: {
                    HStack(spacing: .extraSmall) {
                        Text(viewModel.transactionsSectionButtonTitle)
                            .font(.Paynext.caption)
                            .foregroundStyle(Color.Paynext.secondary)
                        Image(systemName: viewModel.transactionsSectionButtonImageTitle)
                            .resizable()
                            .scaledToFit()
                            .frame(width: .small, height: .small)
                            .foregroundStyle(Color.Paynext.secondary)
                    }
                }
            }
            
            if viewModel.recentTransactions.isEmpty {
                ProgressView()
            } else {
                LazyVStack(spacing: .medium) {
                    ForEach(viewModel.recentTransactions) { row in
                        TransactionRowView(viewModel: row)
                    }
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            viewModel: DashboardViewModel(service: MockTransactionService())
        )
    }
}
