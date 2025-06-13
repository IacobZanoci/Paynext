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

public struct SettingsView<ViewModel: SettingsViewModelProtocol, ThemeManagerType: ThemeManaging>: View {
    
    //MARK: - Dependencies
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var themeManager: ThemeManagerType
    
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
                
                VStack {
                    settingsSection
                    Divider()
                        .padding()
                    darkModeSetting
                    logoutButton
                }
                .padding(.horizontal, .medium)
                Spacer()
            }
        }
    }
}

//MARK: - View Extension

extension  SettingsView {
    
    // MARK: - User Details View
    
    private var userDetails: some View {
        VStack(spacing: .extraSmall) {
            ZStack {
                Circle()
                    .fill(Color.Paynext.secondaryText)
                    .frame(width: 84, height: 84)
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.Paynext.accentText)
                    .frame(width: 84, height: 84)
                    .clipShape(Circle())
            }
            .padding(.top, .extraLarge)
            
            Text("Iacob Zanoci")
                .font(.Paynext.navigationTitleMedium)
                .foregroundStyle(Color.Paynext.accentText)
                .padding(.top, .medium)
            
            Text("929 671-0972")
                .font(.Paynext.footnoteMedium)
                .foregroundStyle(Color.Paynext.accentText.opacity(0.9))
                .padding(.top, .extraSmall)
                .padding(.bottom, .medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.Paynext.tertiaryBackground)
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
        .padding(.top, .extraLarge)
    }
    
    // MARK: - Dark Mode Setting
    
    private var darkModeSetting: some View {
        HStack {
            Text("Dark Mode")
                .font(.Paynext.footnoteMedium)
                .foregroundStyle(Color.Paynext.primaryText)
            Spacer()
            Toggle("", isOn: $themeManager.isDarkModeEnabled)
                .labelsHidden()
                .tint(Color.Paynext.primaryButton)
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
                .filledButton(.quartenary)
        }
        .padding(.top, .medium)
    }
}

//MARK: - Preview

#Preview {
    SettingsView(
        viewModel: MockSettingsViewModel(),
        themeManager: MockThemeManager()
    )
}

final class MockSettingsViewModel: SettingsViewModelProtocol {
    func onLogout() async {}
}

final class MockThemeManager: ThemeManaging, ObservableObject {
    @Published var isDarkModeEnabled: Bool = false
}
