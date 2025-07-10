//
//  TransactionRowViewModelProtocol.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import SwiftUI
import Transaction

public protocol TransactionRowViewModelProtocol: Identifiable, Equatable {
    
    // MARK: - Properties
    
    var id: String { get }
    var title: String { get }
    var formattedDate: String { get }
    var formattedAmount: String { get }
    var amountColor: Color { get }
    var statusIconName: String { get }
    var statusIconColor: Color { get }
    var rawTransaction: TransactionItem { get }
    
    // MARK: - Titles
    
    var detailsSheetTitle: String { get }
    var dismissButtonTitle: String { get }
    var detailsPayeeNameSurnameTitle: String { get }
    var detailsSourceAccountTitle: String { get }
    var detailsPayeeAccountNumberTitle: String { get }
    var detailsPayeeRoutingNumberTitle: String { get }
    var detailsDateTimeTitle: String { get }
    var detailsStatusTitle: String { get }
    var detailsAmountTitle: String { get }
}
