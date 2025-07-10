//
//  TransactionView.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents

public struct TransactionView: View {
    
    // MARK: - Transaction state enum
    
    public enum TransactionState {
        case loading
        case successfully
        case failed
    }
    
    // MARK: - Dependencies
    
    @ObservedObject var vm: TransactionViewModel
    @ObservedObject var paymentVM: PaymentViewModel
    
    // MARK: - Properties
    
    @State private var isAnimating = false
    public var onResetToStart: (() -> Void)?
    
    // MARK: - Initializers
    
    public init(
        vm: TransactionViewModel,
        paymentVM: PaymentViewModel,
        onResetToStart: (() -> Void)? = nil
    ) {
        self._vm = ObservedObject(wrappedValue: vm)
        self.paymentVM = paymentVM
        self.onResetToStart = onResetToStart
    }
    
    // MARK: - View
    
    public var body: some View {
        switch vm.paymentState {
        case .loading:
            loadingStateView()
        case .successfully:
            successStateView()
        case .failed:
            failureStateView()
        }
    }
}

// MARK: - View Extension

extension TransactionView {
    
    private enum Constants {
        static let circleSize: CGFloat = 81
        static let checkMarkSize: CGFloat = 37
        static let successCardWidth: CGFloat = 342
        static let successCardHeight: CGFloat = 388
        static let dividerWidth: CGFloat = 300
        static let verticalPadding: CGFloat = 50
        static let failureCardWidth: CGFloat = 358
        static let failureCardHeight: CGFloat = 358
        static let imageWidth: CGFloat = 121
        static let imageHeight: CGFloat = 78
        static let cardBottomPadding: CGFloat = 230
    }
    
    func confirmationRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.Paynext.secondary)
            Spacer()
            Text(value)
                .foregroundStyle(Color.Paynext.primary)
        }
        .padding(.horizontal, .small)
    }
    
    // MARK: - Success State
    
    func successStateView() -> some View {
        VStack(spacing: .large) {
            ZStack {
                Circle()
                    .fill(Color.Paynext.accent)
                    .frame(width: Constants.circleSize, height: Constants.circleSize)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.white)
                    .frame(width: Constants.checkMarkSize, height: Constants.checkMarkSize)
            }
            Text("Successfully transfered!")
                .font(.Paynext.headline)
                .foregroundStyle(Color.Paynext.primary)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: .large)
                    .stroke(Color.Paynext.tertiary, lineWidth: 1)
                    .frame(width: Constants.successCardWidth, height: Constants.successCardHeight)
                VStack(spacing: .large) {
                    confirmationRow(title: "Recipient", value: paymentVM.name)
                    confirmationRow(title: "Account Number", value: "(929) 617-0714")
                    Divider()
                        .frame(width: Constants.dividerWidth)
                    confirmationRow(title: "You transferred", value: paymentVM.amount)
                    confirmationRow(title: "Payee Account Number", value: paymentVM.accountNumber)
                    confirmationRow(title: "Transaction", value: "84020")
                    confirmationRow(title: "Date & Time", value: paymentVM.formattedStartTime())
                }
                .padding()
            }
            VStack(spacing: .medium) {
                Button(action: {}) {
                    Text("Back to home")
                        .primary()
                }
                .padding(.top, .large)
                
                Button(action: {
                    Task {
                        onResetToStart?()
                    }
                }) {
                    Text("Make another payment")
                        .secondary()
                }
            }
        }
        .padding(.extraLarge)
        .padding(.vertical, Constants.verticalPadding)
        .ignoresSafeArea()
    }
    
    // MARK: - Failure State
    
    func failureStateView() -> some View {
        VStack {
            Text("Transaction Status")
                .font(.Paynext.subheadline)
            
            Divider()
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            ZStack(alignment: .top) {
                VStack {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.Paynext.negative)
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                    
                    VStack(spacing: .medium) {
                        Text("Transaction Failed")
                            .font(.Paynext.headlineBold)
                            .foregroundStyle(Color.Paynext.primary)
                        
                        Text("""
                            There was an issue processing your
                            transaction. Please review the details or contact support.
                            """)
                        .multilineTextAlignment(.center)
                        .font(.Paynext.footnote)
                        .foregroundStyle(Color.Paynext.secondary)
                    }
                    .padding(.horizontal, 2)
                    
                    VStack(spacing: .medium) {
                        Button(action: {
                            Task {
                                onResetToStart?()
                            }
                        }) {
                            Text("Review payment details")
                                .tertiary()
                        }
                        .padding(.top, .large)
                        
                        Button(action: {}) {
                            Text("Go to Dashboard")
                                .secondary(tone: .destructive)
                        }
                    }
                    .padding(.horizontal, .large)
                }
                .padding()
            }
            .padding(.bottom, Constants.cardBottomPadding)
        }
        .padding(.vertical, .medium)
    }
    
    // MARK: - Loading State
    
    func loadingStateView() -> some View {
        VStack {
            Text("Processing Payment")
                .font(.Paynext.subheadline)
            
            Divider()
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            VStack(spacing: .small) {
                Image(systemName: "circle.dotted")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        .linear(duration: 1).repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                    .onAppear {
                        isAnimating = true
                    }
                Text("Transaction in process...")
                    .font(.Paynext.subheadline)
                    .padding(.top, .extraLarge)
                
                Text("We're making sure everything checks out.")
                    .font(.Paynext.footnote)
                    .foregroundStyle(Color.Paynext.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, .medium)
    }
}

// MARK: - Preview

#Preview("Loading State") {
    TransactionView(
        vm: TransactionViewModel(paymentState: .loading),
        paymentVM: PaymentViewModel(credentialsValidator: MockCredentialsValidator()),
        onResetToStart: {}
    )
}

#Preview("Success State") {
    TransactionView(
        vm: TransactionViewModel(paymentState: .successfully),
        paymentVM: PaymentViewModel(credentialsValidator: MockCredentialsValidator()),
        onResetToStart: {}
    )
}

#Preview("Failed State") {
    TransactionView(
        vm: TransactionViewModel(paymentState: .failed),
        paymentVM: PaymentViewModel(credentialsValidator: MockCredentialsValidator()),
        onResetToStart: {}
    )
}
