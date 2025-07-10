//
//  SettingsView.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import SwiftUI
import DesignSystem
import UIComponents
import SettingsDomain
import Persistance

public struct SettingsView<ViewModel: SettingsViewModelProtocol, ThemeManagerType: ThemeManaging>: View {
    
    //MARK: - Dependencies
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var themeManager: ThemeManagerType
    @State private var showFaceIdAlert = false
    
    //MARK: - Initializers
    
    public init (
        viewModel: ViewModel,
        themeManager: ThemeManagerType
    ) {
        self.viewModel = viewModel
        self.themeManager = themeManager
    }
    
    //MARK: - View
    
    public var body: some View {
        ZStack {
            Color.Paynext.background.ignoresSafeArea()
            
            VStack {
                userDetails
                
                VStack(spacing: 0) {
                    settingsSection
                    
                    Divider()
                        .padding()
                    
                    VStack(spacing: .medium) {
                        darkModeSetting
                        pinAccess
                        faceIdAccess
                        remoteSourceTransactions
                    }
                    logoutButton
                }
                .padding(.horizontal, .medium)
                Spacer()
            }
        }
    }
}

//MARK: - Subviews

extension  SettingsView {
    
    // MARK: - User Details View
    
    private var userDetails: some View {
        VStack(spacing: .extraSmall) {
            ZStack {
                Circle()
                    .fill(Color.Paynext.secondary)
                    .frame(width: 84, height: 84)
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.white)
                    .frame(width: 84, height: 84)
                    .clipShape(Circle())
            }
            .padding(.top, .extraLarge)
            
            Text("Iacob Zanoci")
                .font(.Paynext.navigationTitle.weight(.medium))
                .foregroundStyle(Color.white)
                .padding(.top, .medium)
            
            Text("929 671-0972")
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.9))
                .padding(.top, .extraSmall)
                .padding(.bottom, .medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.Paynext.contrast)
    }
    
    // MARK: - Settings Section View
    
    private var settingsSection: some View {
        VStack(spacing: .large) {
            Button {
                // TODO: Personal Information Settings
            } label: {
                SettingsButtonRowView(
                    icon: "person.text.rectangle",
                    title: "Personal Information"
                )
            }
            
            Button {
                // TODO: Card Management Settings
            } label: {
                SettingsButtonRowView(
                    icon: "creditcard",
                    title: "Cards Management"
                )
            }
            
            Button {
                // TODO: Privacy & Security Settings
            } label: {
                SettingsButtonRowView(
                    icon: "shield.lefthalf.filled",
                    title: "Privacy & Security"
                )
            }
            
            Button {
                // TODO: Support Settings
            } label: {
                SettingsButtonRowView(
                    icon: "headset",
                    title: "Support"
                )
            }
        }
        .padding(.horizontal, .large)
        .background(Color.Paynext.background)
        .padding(.vertical, .small)
    }
    
    // MARK: - Dark Mode Setting
    
    private var darkModeSetting: some View {
        HStack {
            Text("Dark Mode")
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            Spacer()
            Toggle("", isOn: $themeManager.isDarkModeEnabled)
                .labelsHidden()
                .tint(Color.Paynext.accent)
        }
        .padding(.horizontal, .medium)
        .background(Color.Paynext.background)
    }
    
    // MARK: - Pin Access
    
    private var pinAccess: some View {
        HStack {
            Toggle(isOn: Binding(
                get: { viewModel.isOn },
                set: { newValue in
                    viewModel.onToggle(toEnable: newValue)
                }
            )) {
                Text(viewModel.pinAccessButton)
                    .font(.Paynext.footnote.weight(.medium))
                    .foregroundStyle(Color.Paynext.primary)
            }
            .tint(Color.Paynext.accent)
            .padding(.horizontal, .medium)
            .background(Color.Paynext.background)
        }
    }
    
    // MARK: - Face ID Access
    
    private var faceIdAccess: some View {
        HStack {
            Text(viewModel.faceIdLabel)
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            Spacer()
            Toggle(isOn: Binding(
                get: { viewModel.isFaceIdOn },
                set: { _ in }
            )) {}
                .labelsHidden()
                .tint(Color.Paynext.accent)
                .disabled(true)
                .contentShape(Rectangle())
                .onTapGesture {
                    guard viewModel.isOn else { return }
                    let nextState = !viewModel.isFaceIdOn
                    viewModel.onToggleFaceId(toEnable: nextState) { success in
                        if !success && nextState {
                            showFaceIdAlert = true
                        }
                    }
                }
                .opacity(viewModel.isOn ? 1 : 0.5)
        }
        .padding(.horizontal, .medium)
        .background(Color.Paynext.background)
        .alert(viewModel.alertTitle, isPresented: $showFaceIdAlert) {
            Button(viewModel.alertDismissButtonTitle, role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    // MARK: - Remote Source Transactions
    
    private var remoteSourceTransactions: some View {
        HStack {
            Text("Use Remote Transactions")
                .font(.Paynext.footnote.weight(.medium))
                .foregroundStyle(Color.Paynext.primary)
            Spacer()
            Toggle("", isOn: Binding(
                get: { viewModel.isRemoteSourceEnabled },
                set: { viewModel.toggleTransactionSource(toRemote: $0) }
            ))
            .labelsHidden()
            .tint(Color.Paynext.accent)
        }
        .padding(.horizontal, .medium)
        .background(Color.Paynext.background)
    }
    
    // MARK: - Logout Button
    
    private var logoutButton: some View {
        Button(action: {
            Task {
                await viewModel.onLogout()
            }
        }) {
            Text("Log out")
                .tertiary()
        }
        .padding(.top, .large)
    }
}

//MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            viewModel: MockSettingsViewModel(),
            themeManager: MockThemeManager()
        )
    }
}
