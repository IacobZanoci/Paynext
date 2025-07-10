//
//  AuthenticationView.swift
//  AuthenticationPresentation
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import SwiftUI
import DesignSystem
import Persistance

public struct AuthenticationView<ViewModel: AuthenticationViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Properties
    
    @FocusState private var focusBinding: Int?
    @State private var showFaceIDAlert = false
    
    // MARK: - Initializers
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack(spacing: .medium) {
            navigationHeader
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
                    pinCodeInput
                    infoText
                }
                pinPad
            }
            Spacer()
        }
        .alert("Face ID Not Enabled", isPresented: $showFaceIDAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please enable Face ID in Settings to use biometric authentication.")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                viewModel.authenticateWithFaceID()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK: - Navigation Header
    
    @ViewBuilder
    private var navigationHeader: some View {
        VStack(spacing: 0) {
            HStack {
                cancelButton
                Spacer()
                Text(viewModel.titleText)
                    .font(.Paynext.navigationTitle.weight(.medium))
                    .foregroundStyle(Color.Paynext.primary)
                Spacer()
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, .medium)
            
            Divider()
                .background(Color.Paynext.tertiary)
        }
    }
    
    // MARK: - Navigation Cancel Button
    
    @ViewBuilder
    private var cancelButton: some View {
        Button(action: {
            viewModel.cancelFlow()
        }) {
            Text("Cancel")
                .font(.Paynext.navigationTitle.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
        }
        .opacity(isCancelVisible ? 1 : 0)
        .disabled(!isCancelVisible)
    }
    
    private var isCancelVisible: Bool {
        switch viewModel.currentStep {
        case .enterNewPin, .confirmNewPin, .disablePin:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Pin Code Input
    
    @ViewBuilder
    private var pinCodeInput: some View {
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
                                             ? .Paynext.negative
                                             : .Paynext.primary
                            )
                            .font(.title)
                            .frame(width: 40, height: 40)
                    }
                    
                    Rectangle()
                        .frame(width: 40, height: 2)
                        .foregroundColor(viewModel.showErrorAlert || viewModel.pinNotMatchingError
                                         ? .Paynext.negative
                                         : .Paynext.primary
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
    }
    
    // MARK: - Info Text
    
    @ViewBuilder
    private var infoText: some View {
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
    
    // MARK: - Pin Length Picker
    
    @ViewBuilder
    private func pinLengthPicker(hidden: Bool) -> some View {
        Picker("", selection: hidden ? .constant(viewModel.selectedOption) : $viewModel.selectedOption) {
            Text("4 digits").tag(0)
            Text("6 digits").tag(1)
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
    
    // MARK: - Pin Pad
    
    @ViewBuilder
    private var pinPad: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
            ForEach(viewModel.buttons, id: \.self) { row in
                ForEach(row, id: \.self) { item in
                    if item.isEmpty {
                        faceIDButton
                    } else {
                        Button(action: {
                            if item == "Clear" {
                                viewModel.handleDelete()
                            } else {
                                viewModel.handleDigit(item)
                            }
                        }) {
                            Text(item)
                                .font(.Paynext.navigationTitle)
                                .frame(width: 80, height: 80)
                                .background(Color.Paynext.contrast)
                                .foregroundStyle(Color.white)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .padding(50)
    }
    
    // MARK: - Face ID Button
    
    @ViewBuilder
    private var faceIDButton: some View {
        if viewModel.currentStep == .enterPin || viewModel.currentStep == .disablePin {
            Button(action: {
                let isEnabled = UserDefaultsManager.shared.get(forKey: .isFaceIDOn) ?? false
                if isEnabled {
                    viewModel.authenticateWithFaceID()
                } else {
                    showFaceIDAlert = true
                }
            }) {
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.Paynext.primary)
            }
        } else {
            Color.clear.frame(width: 50, height: 50)
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

