//
//  TransactionFilterView.swift
//  TransactionHistoryPresentation
//
//  Created by Iacob Zanoci on 17.06.2025.
//

import SwiftUI
import DesignSystem

public struct TransactionFilterView<ViewModel: TransactionFilterViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @StateObject private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    
    @State private var showDateRangePicker: Bool = false
    
    // MARK: - Initializers
    
    public init(
        viewModel: @autoclosure @escaping () -> ViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
            VStack(spacing: .large) {
                navigationBar
                tabSwitcher
                tabContent
                Spacer()
            }
            .padding(.medium)
        }
        .sheet(isPresented: $showDateRangePicker) {
            datePickerView
                .presentationDetents([.fraction(0.34)])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - View Extension

extension TransactionFilterView {
    
    private var navigationBar: some View {
        ZStack {
            Text(viewModel.sheetTitle)
                .font(.Paynext.body)
            
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: viewModel.sheetDismissButtonTitle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .medium, height: .medium)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Paynext.primary)
                }
            }
        }
    }
    
    private var tabSwitcher: some View {
        HStack(spacing: 0) {
            ForEach(FilterTab.allCases, id: \.self) { tab in
                tabSegment(for: tab)
            }
        }
        .padding(.extraSmall)
        .background(Color.Paynext.accent)
        .clipShape(RoundedRectangle(cornerRadius: .small))
    }
    
    @ViewBuilder
    private func tabSegment(for tab: FilterTab) -> some View {
        Button {
            viewModel.selectedTab = tab
        } label: {
            Text(tab.rawValue)
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    Group {
                        if viewModel.selectedTab == tab {
                            RoundedRectangle(cornerRadius: .small)
                                .fill(Color.Paynext.background)
                        } else {
                            Color.clear
                        }
                    }
                )
                .foregroundStyle(
                    viewModel.selectedTab == tab
                    ? Color.Paynext.primary
                    : Color.Paynext.background
                )
        }
    }
    
    // MARK: - Individual Filters View
    
    private var tabContent: some View {
        Group {
            if viewModel.selectedTab == .individual {
                individualFiltersView
            } else {
                presetFiltersView
            }
        }
        .padding(.top, .medium)
    }
    
    private var individualFiltersView: some View {
        VStack(spacing: .medium) {
            textFieldInput(
                title: viewModel.accountNumberMenuTitle,
                text: $viewModel.myAccountNumber,
                icon: viewModel.accountNumberMenuIconTitle
            )
            
            textFieldInput(
                title: viewModel.payeeAccountNumberMenuTitle,
                text: $viewModel.payeeAccountNumber,
                icon: viewModel.payeeAccountNumberMenuIconTitle
            )
            
            textFieldInput(
                title: viewModel.payeeNameMenuTitle,
                text: $viewModel.payeeName,
                icon: viewModel.payeeNameMenuIconTitle
            )
            
            Menu {
                ForEach(viewModel.allStatuses, id: \.self) { status in
                    Button(status.status) {
                        viewModel.transactionStatus = status
                    }
                }
            } label: {
                dropdownField(
                    title: viewModel.transactionStatusMenuTitle,
                    value: viewModel.transactionStatus?.status ?? "",
                    icon: viewModel.transactionStatusMenuIconTitle,
                    onTap: {}
                )
            }
            
            dateRangePicker
            hideCompletedToggle
            Spacer()
            bottomButtons
        }
    }
    
    private var dateRangePicker: some View {
        HStack(spacing: .medium) {
            Text(viewModel.dateRangePickerTitle)
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            
            Spacer()
            
            HStack {
                Text(formattedDate(viewModel.dateRange.lowerBound))
                    .foregroundStyle(Color.white)
                Text(viewModel.dateRangePickerDividerTitle)
                    .foregroundStyle(Color.white)
                Text(formattedDate(viewModel.dateRange.upperBound))
                    .foregroundStyle(Color.white)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: .small)
                    .fill(Color.Paynext.accent)
            )
            .onTapGesture {
                showDateRangePicker = true
            }
        }
        .padding(.top, .medium)
    }
    
    private var datePickerView: some View {
        VStack(spacing: .medium) {
            Text(viewModel.datePickerSheetViewTitle)
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            
            DatePicker(viewModel.sheetStartDatePickerTitle, selection: Binding(
                get: { viewModel.dateRange.lowerBound },
                set: { newStart in
                    viewModel.dateRange = newStart...viewModel.dateRange.upperBound
                }),
                       displayedComponents: .date
            )
            .tint(Color.Paynext.accent)
            .font(.Paynext.footnote.weight(.medium))
            .foregroundStyle(Color.Paynext.primary)
            
            DatePicker(viewModel.sheetEndDatePickerTitle, selection: Binding(
                get: { viewModel.dateRange.upperBound },
                set: { newEnd in
                    viewModel.dateRange = viewModel.dateRange.lowerBound...newEnd
                }),
                       displayedComponents: .date
            )
            .tint(Color.Paynext.accent)
            .font(.Paynext.footnote.weight(.medium))
            .foregroundStyle(Color.Paynext.primary)
            
            Button {
                showDateRangePicker = false
            } label: {
                Text(viewModel.sheetButtonTitle)
                    .primary()
            }
            .padding(.top, .medium)
        }
        .padding(.medium)
    }
    
    private var hideCompletedToggle: some View {
        Toggle(isOn: $viewModel.hideCompleted) {
            Text(viewModel.hideCompletedTransactionTitleToggle)
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
        }
        .toggleStyle(SwitchToggleStyle(tint: Color.Paynext.positive))
        .padding(.top, .large)
    }
    
    private var bottomButtons: some View {
        VStack(spacing: .medium) {
            HStack(spacing: .large) {
                Button {
                    viewModel.applyFilters()
                    dismiss()
                } label: {
                    Text(viewModel.applyFiltersButtonTitle)
                        .primary()
                }
                
                Button {
                    // TODO: Save Preset Logic
                } label: {
                    Text(viewModel.savePresetButtonTitle)
                        .secondary()
                }
            }
            
            Button {
                viewModel.reset()
            } label: {
                Text(viewModel.resetButtonTitle)
                    .tertiary(tone: .destructive)
            }
            .disabled(!viewModel.isResetEnabled)
            .opacity(viewModel.isResetEnabled ? 1 : 0.5)
        }
    }
    
    // MARK: - Preset Filters View
    
    private var presetFiltersView: some View {
        VStack {
            // TODO: Preset settings UI
        }
    }
    
    // MARK: - UI Components
    
    @ViewBuilder
    private func textFieldInput(
        title: String,
        text: Binding<String>,
        icon: String
    ) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: .medium, height: .medium)
                .foregroundStyle(Color.Paynext.primary)
            
            TextField(title, text: text)
                .font(.Paynext.footnote)
                .foregroundStyle(Color.Paynext.primary)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: .small)
                .stroke(Color.Paynext.tertiary)
        )
    }
    
    @ViewBuilder
    private func dropdownField(
        title: String,
        value: String,
        icon: String,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .medium, height: .medium)
                    .foregroundStyle(Color.Paynext.primary)
                Text(value.isEmpty ? title : value)
                    .font(.Paynext.footnote)
                    .foregroundStyle(
                        value.isEmpty
                        ? Color.Paynext.secondary
                        : Color.Paynext.primary
                    )
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.Paynext.tertiary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: .small)
                    .stroke(Color.Paynext.tertiary)
            )
        }
    }
}

// MARK: - Preview

#Preview {
    TransactionFilterView(
        viewModel: TransactionFilterViewModel()
    )
}

// MARK: - Date Formatting Helper

extension TransactionFilterView {
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/MM/yyyy"
        return formatter.string(from: date)
    }
}
