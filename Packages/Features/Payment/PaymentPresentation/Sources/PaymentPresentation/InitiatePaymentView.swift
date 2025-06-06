//
//  InitiatePaymentView.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 06.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents

struct InitiatePaymentView<ViewModel: PaymentViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var vm: ViewModel
    
    // MARK: - Initializers
    
    public init(vm: ViewModel) { self.vm = vm }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
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

// MARK: - View Extension

extension InitiatePaymentView {
    
    // MARK: - Navigation Title
    
    var navigationTitle: some View {
        VStack(spacing: 12) {
            Text("Initiate Payment")
                .font(.Paynext.navigationTitleMedium)
                .foregroundStyle(Color.Paynext.primaryText)
            Divider()
        }
        .padding(.top, 20)
    }
    
    // MARK: - Main Account Option
    
    private var mainAccountOption: some View {
        Button {
            // TODO: - Go to Main Account Options
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "wallet.bifold.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.Paynext.contrastText)
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.Paynext.secondaryBackground)
                    )
                VStack(alignment: .leading) {
                    Text("Main Checking Account")
                        .font(.Paynext.bodyMedium)
                        .foregroundStyle(Color.Paynext.primaryText)
                    Text("$12,345.67")
                        .font(.Paynext.footnote)
                        .foregroundStyle(Color.Paynext.primaryText.opacity(0.6))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.Paynext.caption)
                    .foregroundStyle(Color.Paynext.primaryText.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.Paynext.strokeBackground, lineWidth: 1)
                    .fill(Color.Paynext.background)
            )
        }
    }
    
    // MARK: - Payment Form
    
    private var paymentForm: some View {
        VStack(spacing: 26) {
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.accountNumberTextField)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primaryText)
                RoundedTextFieldView(
                    text: $vm.accountNumber,
                    placeholder: vm.accountNumberPlaceholder,
                    isValid: .constant(true),
                    radius: 6
                )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.routingNumberTextField)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primaryText)
                RoundedTextFieldView(
                    text: $vm.routingNumber,
                    placeholder: vm.routingNumberPlaceholder,
                    isValid: .constant(true),
                    radius: 6
                )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.payeeNameTextField)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primaryText)
                RoundedTextFieldView(
                    text: $vm.payeeName,
                    placeholder: vm.payeeNamePlaceholder,
                    isValid: .constant(true),
                    radius: 6
                )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.amountTextField)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primaryText)
                RoundedTextFieldView(
                    text: $vm.amountRaw,
                    placeholder: vm.amountPlaceholder,
                    isValid: .constant(true),
                    radius: 6,
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
                // TODO: - Proceed Transaction
            } label: {
                Text("Start Proceeding")
                    .filledButton(.quartenary, isDisabled: .constant(true))
            }
        }
        .padding(.top, 40)
    }
}

#Preview {
    NavigationStack {
        InitiatePaymentView<PaymentViewModel>(vm: PaymentViewModel())
    }
}
