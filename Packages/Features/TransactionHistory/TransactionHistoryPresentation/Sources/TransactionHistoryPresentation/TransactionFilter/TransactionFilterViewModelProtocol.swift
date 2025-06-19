//
//  TransactionFilterViewModelProtocol.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 17.06.2025.
//

import Foundation
import SwiftUI

@MainActor
public protocol TransactionFilterViewModelProtocol: ObservableObject {
    
    // MARK: - Tab State
    
    var selectedTab: FilterTab { get set }
    
    // MARK: - Filter Inputs
    
    var myAccountNumber: String { get set }
    var payeeAccountNumber: String { get set }
    var payeeName: String { get set }
    var transactionStatus: String { get set }
    var allStatuses: [String] { get }
    var hideCompleted: Bool { get set }
    var dateRange: ClosedRange<Date> { get set }
    
    // MARK: - State
    
    var isResetEnabled: Bool { get }
    
    // MARK: - Titles
    
    // Sheet
    var sheetTitle: String { get }
    var sheetDismissButtonTitle: String { get }
    
    // Text fields
    var accountNumberMenuTitle: String { get }
    var accountNumberMenuIconTitle: String { get }
    var payeeAccountNumberMenuTitle: String { get }
    var payeeAccountNumberMenuIconTitle: String { get }
    var payeeNameMenuTitle: String { get }
    var payeeNameMenuIconTitle: String { get }
    
    // Drop-down fields
    var transactionStatusMenuTitle: String { get }
    var transactionStatusMenuIconTitle: String { get }
    
    // Date-range Picker
    var dateRangePickerTitle: String { get }
    var dateRangePickerDividerTitle: String { get }
    var datePickerSheetViewTitle: String { get }
    var sheetStartDatePickerTitle: String { get }
    var sheetEndDatePickerTitle: String { get }
    var sheetButtonTitle: String { get }
    
    // Toggle
    var hideCompletedTransactionTitleToggle: String { get }
    
    // Bottom Buttons
    var applyFiltersButtonTitle: String { get }
    var savePresetButtonTitle: String { get }
    var resetButtonTitle: String { get }
    
    // MARK: - Actions
    
    func reset()
    
    // MARK: - Date Formatting
    
    func formattedDate(_ date: Date) -> String
}
