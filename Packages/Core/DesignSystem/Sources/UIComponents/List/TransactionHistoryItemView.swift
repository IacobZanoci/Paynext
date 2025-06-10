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
    let title: String
    let date: String
    let amount: String
    let amountColor: Color
    let cornerRadius: CGFloat = 16
    
    // MARK: - Initializers
    
    public init(
        imageName: String,
        title: String,
        date: String,
        amount: String,
        amountColor: Color
    ) {
        self.imageName = imageName
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
                .frame(width: 18, height: 18)
            VStack(alignment: .leading, spacing: .extraSmall) {
                Text(title)
                    .font(.Paynext.footnoteMedium)
                    .foregroundStyle(Color.Paynext.primaryText.opacity(0.9))
                Text(date)
                    .font(.Paynext.caption)
                    .foregroundStyle(Color.Paynext.primaryText.opacity(0.7))
            }
            Spacer()
            Text(amount)
                .font(.Paynext.footnoteMedium)
                .foregroundStyle(amountColor)
        }
        .padding(.medium)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.Paynext.strokeBackground.opacity(0.9), lineWidth: 1)
        )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        TransactionHistoryItemView(
            imageName: "clock",
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.incomeText
        )
        
        TransactionHistoryItemView(
            imageName: "checkmark.circle",
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.incomeText
        )
        
        TransactionHistoryItemView(
            imageName: "x.circle",
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.incomeText
        )
        
        TransactionHistoryItemView(
            imageName: "exclamationmark.circle",
            title: "James May",
            date: "12:30 10/06/2025",
            amount: "+$300.00",
            amountColor: Color.Paynext.incomeText
        )
    }
    .padding()
}
