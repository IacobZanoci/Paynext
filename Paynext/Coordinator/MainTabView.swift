//
//  MainView.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

import SwiftUI
import DesignSystem
import PaymentPresentation
import CredentialsValidator
import TransactionHistoryPresentation
import Transaction
import SettingsPresentation
import Persistance
import DashboardPresentation
import BiometricsAuth

struct MainTabView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab = 0
    @State private var historyViewKey = UUID()
    
    // MARK: - Dependencies
    
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var transactionVMProvider: TransactionHistoryViewModelProvider
    @StateObject private var settingsVM: SettingsViewModel
    
    // MARK: - Coordinators
    
    @StateObject private var homeCoordinator = AppCoordinator()
    @StateObject private var historyCoordinator = AppCoordinator()
    @StateObject private var paymentCoordinator = AppCoordinator()
    @StateObject private var accountCoordinator = AppCoordinator()
    
    // MARK: - ViewModels
    
    @StateObject private var paymentVM = PaymentViewModel(
        credentialsValidator: CredentialsValidator()
    )
    
    // MARK: - Initializers
    
    init(coordinator: AppCoordinator) {
        let appearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.Paynext.background
        appearance.shadowColor = UIColor.systemGray5
        
        itemAppearance.normal.iconColor = UIColor.Paynext.inactive
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.Paynext.inactive,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        itemAppearance.selected.iconColor = UIColor.Paynext.active
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.Paynext.active,
            .font: UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        
        appearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        let userDefaults = UserDefaultsManager()
        let notificationCenter: NotificationCenterProtocol = NotificationCenter.default
        let biometricsService = BiometricsService(
            storage: userDefaults,
            notificationCenter: notificationCenter
        )
        
        let settingsVM = SettingsViewModel(
            persistenceStorage: userDefaults,
            notificationCenter: notificationCenter,
            biometricsService: biometricsService,
            onLogout: { [weak coordinator] in
                coordinator?.setRoot(to: .login)
            },
            onTogglePinAction: { [weak accountCoordinator = coordinator] toEnable in
                guard let coordinator = accountCoordinator else { return }
                coordinator.navigate(to: toEnable ? .enterNewPin : .disablePin)
            }
        )
        
        _accountCoordinator = StateObject(wrappedValue: coordinator)
        _settingsVM = StateObject(wrappedValue: settingsVM)
        _transactionVMProvider = StateObject(
            wrappedValue: TransactionHistoryViewModelProvider(settings: settingsVM)
        )
    }
    
    // MARK: - View
    
    var body: some View {
        
        // MARK: - Home TabBar View
        
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homeCoordinator.navigationPath) {
                DashboardView(
                    viewModel: DashboardViewModel(service: MockTransactionService()),
                    onSeeAllTap: { selectedTab = 1 },
                    onTransferTap: { selectedTab = 2 }
                )
                .navigationDestination(for: AppRoute.self) { route in
                    homeCoordinator.view(
                        route: route,
                        coordinator: homeCoordinator
                    )
                }
                .environmentObject(homeCoordinator)
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                Text("Home")
            }
            .tag(0)
            
            // MARK: - History TabBar View
            
            NavigationStack(path: $historyCoordinator.navigationPath) {
                TransactionHistoryView(viewModel: transactionVMProvider.viewModel)
                    .id(historyViewKey)
                    .navigationDestination(for: AppRoute.self) { route in
                        historyCoordinator.view(route: route, coordinator: historyCoordinator)
                    }
                    .environmentObject(historyCoordinator)
                    .onReceive(transactionVMProvider.$viewModel) { _ in
                        historyViewKey = UUID()
                    }
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "book.pages.fill" : "book.pages")
                Text("History")
            }
            .tag(1)
            
            // MARK: - Payment TabBar View
            
            NavigationStack(path: $paymentCoordinator.navigationPath) {
                InitiatePaymentView(
                    vm: paymentVM,
                    onResetToStart: { paymentVM.paymentState = nil }
                )
                .navigationDestination(for: AppRoute.self) { route in
                    paymentCoordinator.view(
                        route: route,
                        coordinator: paymentCoordinator
                    )
                }
                .environmentObject(paymentCoordinator)
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "creditcard.fill" : "creditcard")
                Text("Payment")
            }
            .tag(2)
            
            // MARK: - Account TabBar View
            
            NavigationStack(path: $accountCoordinator.navigationPath) {
                SettingsView(
                    viewModel: settingsVM,
                    themeManager: themeManager
                )
                .navigationDestination(for: AppRoute.self) { route in
                    accountCoordinator.view(
                        route: route,
                        coordinator: accountCoordinator
                    )
                }
                .environmentObject(accountCoordinator)
                .environmentObject(themeManager)
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "person.circle.fill" : "person.circle")
                Text("Account")
            }
            .tag(3)
        }
    }
}

#Preview {
    MainTabView(coordinator: AppCoordinator())
        .environmentObject(AppCoordinator())
        .environmentObject(ThemeManager())
}
