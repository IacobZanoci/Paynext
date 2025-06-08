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

struct MainTabView: View {
    
    // MARK: - Properties
    
    @StateObject private var homeCoordinator = AppCoordinator()
    @StateObject private var historyCoordinator = AppCoordinator()
    @StateObject private var paymentCoordinator = AppCoordinator()
    @StateObject private var accountCoordinator = AppCoordinator()
    @StateObject private var paymentVM = PaymentViewModel(
        credentialsValidator: CredentialsValidator()
    )
    
    @State private var selectedTab = 0
    
    // MARK: - Initializers
    
    init() {
        let appearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.Paynext.tabBarBackground
        appearance.shadowColor = UIColor.systemGray5
        
        itemAppearance.normal.iconColor = UIColor.Paynext.normalTabBar
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.Paynext.normalTabBar,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        itemAppearance.selected.iconColor = UIColor.Paynext.selectedTabBar
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.Paynext.selectedTabBar,
            .font: UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        
        appearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // MARK: - View
    
    var body: some View {
        
        // MARK: - Home TabBar View
        
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homeCoordinator.navigationPath) {
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        homeCoordinator.view(route: route)
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
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        historyCoordinator.view(route: route)
                    }
                    .environmentObject(historyCoordinator)
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
                    paymentCoordinator.view(route: route)
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
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        accountCoordinator.view(route: route)
                    }
                    .environmentObject(accountCoordinator)
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
    MainTabView()
}
