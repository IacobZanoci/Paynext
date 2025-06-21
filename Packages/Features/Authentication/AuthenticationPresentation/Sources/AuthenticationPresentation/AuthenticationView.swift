//
//  AuthenticationView.swift
//  AuthenticationPresentation
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import SwiftUI
import DesignSystem

public struct AuthenticationView<ViewModel: AuthenticationViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Properties
    
    @FocusState private var focusBinding: Int?
    
    // MARK: - Initializers
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack(spacing: .medium) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        viewModel.cancelFlow()
                    }) {
                        Text(viewModel.cancelButton)
                            .font(.Paynext.navigationTitleMedium)
                            .foregroundStyle(Color.Paynext.primaryText)
                    }
                    .opacity(viewModel.currentStep == .confirmNewPin ? 1 : 0)
                    .disabled(viewModel.currentStep != .confirmNewPin)
                    Spacer()
                    Text(viewModel.titleText)
                        .font(.Paynext.navigationTitleMedium)
                        .foregroundStyle(Color.Paynext.primaryText)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, .medium)
                
                Divider()
                    .background(Color.gray.opacity(0.3))
            }
            VStack {
                VStack {
                    if viewModel.currentStep == .enterNewPin {
                        pinLengthPicker(hidden: false)
                    } else {
                        pinLengthPicker(hidden: true)
                    }
                }
                .padding(.horizontal, 50)
                .padding(.vertical, .small)
                
                VStack(spacing: .extraLarge) {
                    HStack(spacing: .medium) {
                        ForEach(0..<viewModel.pin.count, id: \.self) { index in
                            VStack {
                                ZStack {
                                    TextField("", text: $viewModel.pin[index])
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .foregroundStyle(Color.clear)
                                        .accentColor(.black)
                                        .focused($focusBinding, equals: index)
                                        .onChange(of: viewModel.pin[index]) { _, newValue in
                                            if newValue.count > 1 {
                                                viewModel.pin[index] = String(newValue.prefix(1))
                                            }
                                            if !newValue.isEmpty && index < viewModel.pin.count - 1 {
                                                viewModel.focusedIndex = index + 1
                                            }
                                        }
                                    
                                    Text(viewModel.pin[index].isEmpty ? "" : "*")
                                        .foregroundColor(viewModel.showErrorAlert
                                                         ? .Paynext.errorStrokeBackground
                                                         : .Paynext.primaryText
                                        )
                                        .font(.title)
                                        .frame(width: 40, height: 40)
                                }
                                
                                Rectangle()
                                    .frame(width: 40, height: 2)
                                    .foregroundColor(viewModel.showErrorAlert || viewModel.pinNotMatchingError
                                                     ? .Paynext.errorStrokeBackground
                                                     : .Paynext.primaryText
                                    )
                            }
                        }
                    }
                    .onChange(of: viewModel.focusedIndex) { _, newIndex in
                        focusBinding = newIndex
                    }
                    .onAppear {
                        focusBinding = viewModel.focusedIndex
                    }
                    
                    VStack {
                        Text(viewModel.errorOrInfoText)
                            .font(.Paynext.caption)
                            .foregroundStyle(viewModel.errorTextColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .transition(.opacity)
                            .id(viewModel.errorOrInfoText)
                    }
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(viewModel.buttons, id: \.self) { row in
                        ForEach(row, id: \.self) { item in
                            if item.isEmpty {
                                Color.clear
                                    .frame(width: 80, height: 80)
                            } else {
                                Button(action: {
                                    if item == viewModel.clearButton {
                                        viewModel.handleDelete()
                                    } else {
                                        viewModel.handleDigit(item)
                                    }
                                }) {
                                    Text(item)
                                        .font(.Paynext.navigationTitle)
                                        .frame(width: 80, height: 80)
                                        .background(Color.Paynext.primaryText)
                                        .foregroundStyle(Color.Paynext.contrastText)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                }
                .padding(50)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    private func pinLengthPicker(hidden: Bool) -> some View {
        Picker("", selection: hidden ? .constant(viewModel.selectedOption) : $viewModel.selectedOption) {
            Text(viewModel.fourDigitOption).tag(0)
            Text(viewModel.sixDigitOption).tag(1)
        }
        .pickerStyle(.segmented)
        .background(hidden ? Color.clear : Color.Paynext.background)
        .opacity(hidden ? 0 : 1)
        .disabled(hidden)
        .onChange(of: viewModel.selectedOption) { _, _ in
            if !hidden {
                viewModel.resetState()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AuthenticationView(
        viewModel: AuthenticationViewModel(
            flow: .setupNewPin,
            onPinSuccess: {},
            onPin: {}
        )
    )
}

