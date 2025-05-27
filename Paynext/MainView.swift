//
//  MainView.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject private var homeCoordinator = AppCoordinator()
    @StateObject private var historyCoordinator = AppCoordinator()
    @StateObject private var paymentCoordinator = AppCoordinator()
    @StateObject private var accountCoordinator = AppCoordinator()
    
    @State private var selectedTab = 0
    
    // MARK: - Initializers
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor.lightGray
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
                        homeCoordinator.build(route: route)
                    }
                    .environmentObject(homeCoordinator)
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "star.fill" : "star")
            }
            .tag(0)
            
            // MARK: - History TabBar View
            
            NavigationStack(path: $historyCoordinator.navigationPath) {
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        historyCoordinator.build(route: route)
                    }
                    .environmentObject(historyCoordinator)
            }
            .tabItem {
                Label("History", systemImage: selectedTab == 0 ? "star.fill" : "star")
            }
            .tag(1)
            
            // MARK: - Payment TabBar View
            
            NavigationStack(path: $paymentCoordinator.navigationPath) {
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        paymentCoordinator.build(route: route)
                    }
                    .environmentObject(paymentCoordinator)
            }
            .tabItem {
                Label("Payment", systemImage: selectedTab == 0 ? "star.fill" : "star")
            }
            .tag(2)
            
            // MARK: - Account TabBar View
            
            NavigationStack(path: $accountCoordinator.navigationPath) {
                EmptyView()
                    .navigationDestination(for: AppRoute.self) { route in
                        accountCoordinator.build(route: route)
                    }
                    .environmentObject(accountCoordinator)
            }
            .tabItem {
                Label("Account", systemImage: selectedTab == 0 ? "star.fill" : "star")
            }
            .tag(3)
        }
    }
}


#Preview {
    MainView()
}
