//
//  TransactionDetailsView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents

public struct TransactionDetailsView: View {
    
    // MARK: - Dependencies
    
    //let transaction: Transaction
    
    // MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            ZStack {
                Text("Transaction details")
                    .font(.Paynext.body)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.Paynext.bodyBold)
                            .imageScale(.large)
                            .foregroundStyle(Color.Paynext.primaryText)
                    }
                    .padding(.trailing, .large)
                }
            }
            .frame(maxWidth: .infinity)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: .large)
                    .stroke(Color.Paynext.strokeBackground, lineWidth: 1)
                    .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                VStack(spacing: .large) {
                    // TODO: Replace hardcoded values with dynamic data from JSON file.
                    confirmationRow(title: "Payee Name", value: "James May")
                    confirmationRow(title: "Source Account", value: "(929) 617-0714")
                    confirmationRow(title: "Payee Account Number", value: "3412 3456")
                    confirmationRow(title: "Payee Routing Number", value: "34535")
                    confirmationRow(title: "Date & Time", value: "12:30 21/07/2025")
                    confirmationRow(title: "Status", value: "Completed")
                    confirmationRow(title: "Amount", value: "$300")
                }
                .padding()
            }
            .padding(.horizontal, .large)
            .padding(.vertical, .large)
        }
    }
}

// MARK: - View Extension

extension TransactionDetailsView {
    
    private enum Constants {
        static let cardWidth: CGFloat = 342
        static let cardHeight: CGFloat = 400
        static let dividerWidth: CGFloat = 310
    }
    
    func confirmationRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.secondaryText)
            Spacer()
            Text(value)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.primaryText)
        }
        .padding(.horizontal, .small)
    }
}

// MARK: - Preview

#Preview {
    TransactionDetailsView()
}
