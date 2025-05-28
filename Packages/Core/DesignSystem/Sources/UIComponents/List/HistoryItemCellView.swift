//
//  HistoryItemCellView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public enum TransactionType {
    case income
    case outcome
    
    var color: Color {
        switch self {
        case .income:
            return Color.Paynext.incomeText
        case .outcome:
            return Color.Paynext.outcomeText
        }
    }
    
    var symbol: String {
        switch self {
        case .income:
            return "+"
        case .outcome:
            return "-"
        }
    }
}

public struct HistoryItemCellView: View {
    
    public let title: String
    public let date: String
    public let time: String
    public let transaction: String
    public let transactionType: TransactionType
    
    public init(
        title: String,
        date: String,
        time: String,
        transaction: String,
        transactionType: TransactionType
    ) {
        self.title = title
        self.date = date
        self.time = time
        self.transaction = transaction
        self.transactionType = transactionType
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .extraSmall) {
                Text(title)
                    .font(.Paynext.bodyBold)
                    .foregroundStyle(Color.Paynext.primaryText)
                Text("\(date) \(time)")
                    .font(.Paynext.body)
                    .foregroundStyle(Color.Paynext.tertiaryText)
            }
            Spacer()
            Text("\(transactionType.symbol) \(transaction)")
                .font(.Paynext.bodyBold)
                .foregroundStyle(transactionType.color)
        }
        .padding()
        .background(Color.Paynext.background)
        .clippedRoundedCorners(24)
    }
}

#Preview {
    HistoryItemCellView(
        title: "Paynext User",
        date: "12/05/25",
        time: "12:34",
        transaction: "150$",
        transactionType: .income
    )
    .padding(.horizontal)
}
