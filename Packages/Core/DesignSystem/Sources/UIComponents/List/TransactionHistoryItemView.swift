//
//  TransactionHistoryItemView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 10.06.2025.
//

import SwiftUI
import DesignSystem

public struct TransactionHistoryItemView: View {
    
    // MARK: - Properties
    
    let imageName: String
    let statusIconColor: Color
    let title: String
    let date: String
    let amount: String
    let amountColor: Color
    
    // MARK: - Initializers
    
    public init(
        imageName: String,
        statusIconColor: Color,
        title: String,
        date: String,
        amount: String,
        amountColor: Color
    ) {
        self.imageName = imageName
        self.statusIconColor = statusIconColor
        self.title = title
        self.date = date
        self.amount = amount
        self.amountColor = amountColor
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack(alignment: .top) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(statusIconColor)
                .frame(width: .medium, height: .medium)
            VStack(alignment: .leading, spacing: .extraSmall) {
                Text(title)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primary)
                Text(date)
                    .font(.Paynext.caption)
                    .foregroundStyle(Color.Paynext.secondary)
            }
            Spacer()
            Text(amount)
                .font(.Paynext.footnoteMedium)
                .foregroundStyle(amountColor)
        }
        .padding(.medium)
        .background(
            RoundedRectangle(cornerRadius: .medium)
                .stroke(Color.Paynext.tertiary, lineWidth: 1)
        )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        TransactionHistoryItemView(
            imageName: "clock",
            statusIconColor: .Paynext.secondary,
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.positive
        )
        
        TransactionHistoryItemView(
            imageName: "checkmark.circle",
            statusIconColor: .Paynext.positive,
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.positive
        )
        
        TransactionHistoryItemView(
            imageName: "x.circle",
            statusIconColor: .Paynext.negative,
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.positive
        )
        
        TransactionHistoryItemView(
            imageName: "exclamationmark.circle",
            statusIconColor: .Paynext.negative,
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.positive
        )
    }
    .padding()
}
