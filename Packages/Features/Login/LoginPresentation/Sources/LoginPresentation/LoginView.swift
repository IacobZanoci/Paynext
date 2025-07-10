//
//  LoginView.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import SwiftUI
import Combine
import DesignSystem
import UIComponents

public struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State private var keyboardVisible: Bool = false
    @State private var showForm: Bool = false
    
    // MARK: - Initializers
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Login View
    
    public var body: some View {
        ZStack {
            Color.Paynext.contrast.ignoresSafeArea()
            
            VStack {
                appIcon
                Spacer()
            }
            
            if showForm {
                loginForm
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showForm = true
                }
            }
        }
        .onReceive(Publishers.keyboardVisible) { isVisible in
            withAnimation(.easeInOut(duration: 0.1)) {
                self.keyboardVisible = isVisible
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Login View Extension

extension LoginView {
    private var appIcon: some View {
        VStack(spacing: 0) {
            Image(viewModel.appIconTitle, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, showForm ? 120 : 0)
        .offset(y: showForm ? 0 : UIScreen.main.bounds.height / 3)
        .animation(.easeInOut(duration: 0.4), value: showForm)
    }
    
    private var loginForm: some View {
        ScrollView {
            VStack {
                Text(viewModel.loginFormTitle)
                    .font(.Paynext.headline.weight(.bold))
                    .foregroundStyle(Color.Paynext.primary)
                    .padding(.bottom, 6)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        RoundedTextFieldView(
                            text: $viewModel.userName,
                            placeholder: viewModel.nameSurnamePlaceholder,
                            isValid: $viewModel.usernameValidationState,
                            title: viewModel.nameSurnameTitle
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        RoundedTextFieldView(
                            text: $viewModel.accountNumber,
                            placeholder: viewModel.accountNumberPlaceholder,
                            isValid: $viewModel.accountNumberValidationState,
                            title: viewModel.accountNumberTitle
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        RoundedTextFieldView(
                            text: $viewModel.routingNumber,
                            placeholder: viewModel.routingNumberPlaceholder,
                            isValid: $viewModel.routingNumberValidationState,
                            title: viewModel.routingNumberTitle
                        )
                    }
                }
                
                Button {
                    Task {
                        await viewModel.onLogin()
                    }
                } label : {
                    Text(viewModel.loginButtonTitle)
                        .primary()
                }
                .disabled(viewModel.isLoginDisabled)
                .padding(.top, 50)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 54)
        .background(Color.Paynext.background)
        .clippedRoundedCorners(16)
        .padding(.top, keyboardVisible ? 60 : 340)
        .animation(.easeInOut(duration: 0.2), value: keyboardVisible)
    }
}
