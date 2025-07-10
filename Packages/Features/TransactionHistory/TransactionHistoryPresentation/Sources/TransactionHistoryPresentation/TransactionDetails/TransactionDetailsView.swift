//
//  TransactionDetailsView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents
import Transaction

// MARK: - Expandable TextFields Enum

enum Field: Hashable {
    case payerAccount
    case payeeAccount
}

public struct TransactionDetailsView<ViewModel: TransactionRowViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    let viewModel: ViewModel
    
    // MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    @State private var expandedFields: Set<Field> = []
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            ZStack {
                Text(viewModel.detailsSheetTitle)
                    .font(.Paynext.body)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: viewModel.dismissButtonTitle)
                            .font(.Paynext.body.weight(.bold))
                            .imageScale(.large)
                            .foregroundStyle(Color.Paynext.primary)
                    }
                    .padding(.trailing, .large)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: .large) {
                confirmationRow(
                    title: viewModel.detailsPayeeNameSurnameTitle,
                    value: viewModel.rawTransaction.payeeName,
                    field: .payerAccount,
                    isExpandable: false
                )
                confirmationRow(
                    title: viewModel.detailsSourceAccountTitle,
                    value: viewModel.rawTransaction.payerAccountNumber,
                    field: .payerAccount,
                    isExpandable: true
                )
                
                Divider()
                
                confirmationRow(
                    title: viewModel.detailsPayeeAccountNumberTitle,
                    value: viewModel.rawTransaction.payeeAccountNumber,
                    field: .payeeAccount,
                    isExpandable: true
                )
                confirmationRow(
                    title: viewModel.detailsPayeeRoutingNumberTitle,
                    value: viewModel.rawTransaction.payeeRoutingNumber,
                    field: .payerAccount,
                    isExpandable: false
                )
                confirmationRow(
                    title: viewModel.detailsDateTimeTitle,
                    value: viewModel.formattedDate,
                    field: .payerAccount,
                    isExpandable: false
                )
                confirmationRow(
                    title: viewModel.detailsStatusTitle,
                    value: viewModel.rawTransaction.status,
                    field: .payerAccount,
                    isExpandable: false
                )
                confirmationRow(
                    title: viewModel.detailsAmountTitle,
                    value: viewModel.formattedAmount,
                    field: .payerAccount,
                    isExpandable: false
                )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: .large)
                    .stroke(Color.Paynext.tertiary, lineWidth: 1)
            )
            .padding(.horizontal, .large)
            .padding(.vertical, .large)
            
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - View Extension

extension TransactionDetailsView {
    
    @ViewBuilder
    func confirmationRow(
        title: String,
        value: String,
        field: Field,
        isExpandable: Bool = false) -> some View
    {
        let isExpanded = expandedFields.contains(field)
        let displayValue = isExpandable && !isExpanded ? value.shortened() : value
        
        HStack(alignment: .top) {
            Text(title)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.secondary)
            Spacer()
            Text(displayValue)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.primary)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    if isExpandable {
                        if isExpanded {
                            expandedFields.remove(field)
                        } else {
                            expandedFields.insert(field)
                        }
                    }
                }
        }
        .padding(.horizontal, .small)
    }
}

// MARK: - String Field Extension

extension String {
    func shortened(
        limit: Int = 20,
        prefixLenght: Int = 8,
        suffixLength: Int = 4) -> String
    {
        guard count > limit else { return self }
        let prefix = prefix(prefixLenght)
        let suffix = suffix(suffixLength)
        return "\(prefix)...\(suffix)"
    }
}

// MARK: - Preview

#Preview {
    TransactionDetailsView(
        viewModel: TransactionRowViewModel(
            transaction: TransactionItem(
                id: UUID(),
                payeeName: "Iacob Zanoci",
                payeeAccountNumber: "MDINCB000000000001234567000",
                payeeRoutingNumber: "MD-123456789",
                payerName: "Anastasia Ivlev",
                payerAccountNumber: "BOFATX000000000001234567111",
                transactionAmount: 200.00,
                transactionDate: "2025-08-23",
                status: "COMPLETED",
                createdAt: "2025-08-23T12:30:00",
                updatedAt: "2025-08-23T12:30:00"
            )
        )
    )
}
