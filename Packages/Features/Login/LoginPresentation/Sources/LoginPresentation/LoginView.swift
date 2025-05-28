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

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var accountNumber: String = ""
    @State private var routingNumber: String = ""
    @State private var keyboardVisible: Bool = false
    @State private var showForm: Bool = false
    
    public init () {}
    
    var body: some View {
        ZStack {
            Color.Paynext.secondaryBackground.ignoresSafeArea()
            
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

extension LoginView {
    private var appIcon: some View {
        VStack(spacing: 0) {
            Image("appIcon", bundle: .module)
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
                Text("Log in")
                    .font(.Paynext.headlineBold)
                    .foregroundStyle(Color.Paynext.primaryText)
                    .padding(.bottom, 6)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Username")
                            .font(.Paynext.bodyBold)
                            .foregroundStyle(Color.Paynext.primaryText)
                        RoundedTextFieldView(text: $username, placeholder: "Enter name and surname")
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account number")
                            .font(.Paynext.bodyBold)
                            .foregroundStyle(Color.Paynext.primaryText)
                        RoundedTextFieldView(text: $accountNumber, placeholder: "Enter account number")
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Routing number")
                            .font(.Paynext.bodyBold)
                            .foregroundStyle(Color.Paynext.primaryText)
                        RoundedTextFieldView(text: $routingNumber, placeholder: "Enter routing number")
                    }
                }
                
                Button {
                    // Login action
                } label : {
                    Text("Log in")
                        .filledButton(.primary)
                }
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

#Preview {
    LoginView()
}
