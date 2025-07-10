//
//  InitiatePaymentView.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents
import CredentialsValidator

public struct InitiatePaymentView<ViewModel: PaymentViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @ObservedObject var vm: ViewModel
    
    // MARK: - Properties
    
    public var onResetToStart: (() -> Void)?
    
    // MARK: - Initializers
    
    public init(
        vm: ViewModel,
        onResetToStart: (() -> Void)? = nil
    ) {
        self.vm = vm
        self.onResetToStart = onResetToStart
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
            if let paymentState = vm.paymentState {
                TransactionView(
                    vm: .init(paymentState: paymentState),
                    paymentVM: vm as! PaymentViewModel,
                    onResetToStart: onResetToStart
                )
                .toolbar(.hidden, for: .tabBar)
            } else {
                VStack {
                    navigationTitle
                    
                    ScrollView {
                        VStack {
                            mainAccountOption
                            paymentForm
                            proceedButton
                        }
                        .scrollIndicators(.hidden)
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

// MARK: - View Extension

extension InitiatePaymentView {
    
    // MARK: - Navigation Title
    
    var navigationTitle: some View {
        VStack(spacing: 12) {
            Text("Initiate Payment")
                .font(.Paynext.navigationTitle.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            Divider()
        }
        .padding(.top, 20)
    }
    
    // MARK: - Main Account Option
    
    private var mainAccountOption: some View {
        Button {
            // TODO: - Go to Main Account Options
        } label: {
            HStack(spacing: .medium) {
                Image(systemName: "wallet.bifold.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.white)
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.Paynext.accent)
                    )
                VStack(alignment: .leading) {
                    Text("Main Checking Account")
                        .font(.Paynext.body.weight(.medium))
                        .foregroundStyle(Color.Paynext.primary)
                    Text("$12,345.67")
                        .font(.Paynext.footnote)
                        .foregroundStyle(Color.Paynext.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.Paynext.caption)
                    .foregroundStyle(Color.Paynext.secondary)
            }
            .padding(.horizontal, .medium)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: .medium)
                    .stroke(Color.Paynext.tertiary, lineWidth: 1)
                    .fill(Color.Paynext.background)
            )
        }
    }
    
    // MARK: - Payment Form
    
    private var paymentForm: some View {
        VStack(spacing: 26) {
            VStack(alignment: .leading, spacing: .small) {
                RoundedTextFieldView(
                    text: $vm.accountNumber,
                    placeholder: vm.accountNumberPlaceholder,
                    isValid: $vm.accountNumberValidationState,
                    title: vm.accountNumberTextField,
                    radius: .medium
                )
            }
            
            VStack(alignment: .leading, spacing: .small) {
                RoundedTextFieldView(
                    text: $vm.routingNumber,
                    placeholder: vm.routingNumberPlaceholder,
                    isValid: $vm.routingNumberValidationState,
                    title: vm.routingNumberTextField,
                    radius: .medium
                )
            }
            
            VStack(alignment: .leading, spacing: .small) {
                RoundedTextFieldView(
                    text: $vm.name,
                    placeholder: vm.payeeNamePlaceholder,
                    isValid: $vm.nameValidationState,
                    title: vm.payeeNameTextField,
                    radius: .medium
                )
            }
            
            VStack(alignment: .leading, spacing: .small) {
                RoundedTextFieldView(
                    text: $vm.amount,
                    placeholder: vm.amountPlaceholder,
                    isValid: $vm.amountValidationState,
                    title: vm.amountTextField,
                    radius: .medium,
                    leftIcon: "dollarsign"
                )
                .keyboardType(.decimalPad)
            }
        }
        .padding(.top, 24)
    }
    
    // MARK: - Proceed Button
    
    private var proceedButton: some View {
        HStack {
            Button {
                Task { @MainActor [weak vm] in
                    await vm?.onStartProceeding()
                }
            } label: {
                Text("Start Proceeding")
                    .primary()
            }
            .disabled(vm.isStartProceedingDisabled)
        }
        .padding(.top, 40)
    }
}

#Preview {
    NavigationStack {
        InitiatePaymentView<PaymentViewModel>(
            vm: PaymentViewModel(credentialsValidator: MockCredentialsValidator())
        )
    }
}
