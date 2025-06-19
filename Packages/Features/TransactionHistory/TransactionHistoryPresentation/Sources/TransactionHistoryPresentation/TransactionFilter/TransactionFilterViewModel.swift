//
//  TransactionFilterViewModel.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 17.06.2025.
//

import Foundation

public enum FilterTab: String, CaseIterable, Equatable {
    
    case individual = "Individual Filters"
    case preset = "Preset Filters"
}

public final class TransactionFilterViewModel: TransactionFilterViewModelProtocol {
    
    // MARK: - Tab State
    
    @Published public var selectedTab: FilterTab = .individual
    
    // MARK: - Filter Inputs
    
    @Published public var myAccountNumber: String = ""
    @Published public var payeeAccountNumber: String = ""
    @Published public var payeeName: String = ""
    @Published public var transactionStatus: String = ""
    @Published public var allStatuses: [String] = ["COMPLETED", "PROCESSING", "FAILED", "REJECTED"]
    @Published public var hideCompleted: Bool = false
    @Published public var dateRange: ClosedRange<Date>
    
    // MARK: - Constants
    
    private let defaultDateRangeValue: ClosedRange<Date>
    
    // MARK: - State
    
    public var isResetEnabled: Bool {
        !myAccountNumber.isEmpty ||
        !payeeAccountNumber.isEmpty ||
        !payeeName.isEmpty ||
        !transactionStatus.isEmpty ||
        hideCompleted ||
        dateRange != defaultDateRangeValue
    }
    
    // MARK: - Titles
    
    // Sheet
    @Published public var sheetTitle: String = "Filter"
    @Published public var sheetDismissButtonTitle: String = "xmark"
    
    // Text fields
    @Published public var accountNumberMenuTitle: String = "My Account Number"
    @Published public var accountNumberMenuIconTitle: String = "person"
    
    @Published public var payeeAccountNumberMenuTitle: String = "Payee Account Number"
    @Published public var payeeAccountNumberMenuIconTitle: String = "numbers.rectangle"
    
    @Published public var payeeNameMenuTitle: String = "Payee Name"
    @Published public var payeeNameMenuIconTitle: String = "character.textbox"
    
    // Drop-down fields
    @Published public var transactionStatusMenuTitle: String = "Transaction Status"
    @Published public var transactionStatusMenuIconTitle: String = "ellipsis.rectangle"
    
    // Date-range Picker
    @Published public var dateRangePickerTitle: String = "Transaction Date"
    @Published public var dateRangePickerDividerTitle: String = "-"
    @Published public var datePickerSheetViewTitle: String = "Select Transaction Date Range"
    @Published public var sheetStartDatePickerTitle: String = "Start Date"
    @Published public var sheetEndDatePickerTitle: String = "End Date"
    @Published public var sheetButtonTitle: String = "Done"
    
    // Toggle
    @Published public var hideCompletedTransactionTitleToggle: String = "Hide Completed Transactions"
    
    // Bottom Buttons
    @Published public var applyFiltersButtonTitle: String = "Apply Filters"
    @Published public var savePresetButtonTitle: String = "Save Preset"
    @Published public var resetButtonTitle: String = "Reset"
    
    // MARK: - Initializers
    
    public init() {
        let calendar = Calendar.current
        let now = Date()
        
        // First day of current month
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        
        // Last day of current month
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let endOfMonth = calendar.date(byAdding: components, to: startOfMonth)!
        
        let defaultRange = startOfMonth...endOfMonth
        self.dateRange = defaultRange
        self.defaultDateRangeValue = defaultRange
    }
    
    // MARK: - Actions
    
    public func reset() {
        myAccountNumber = ""
        payeeAccountNumber = ""
        payeeName = ""
        transactionStatus = ""
        hideCompleted = false
        dateRange = defaultDateRangeValue
    }
    
    // MARK: - Date Formatting
    
    public func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/MM/yyyy"
        return formatter.string(from: date)
    }
}
