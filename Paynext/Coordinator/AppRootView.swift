//
//  AppRootView.swift
//  Paynext
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import SwiftUI

/// The root view of the app.
///
/// Uses NavigationStack to display the view that should be used as the main entry point.
struct AppRootView: View {
    
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some View {
        
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.view(route: coordinator.currentRoute)
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.view(route: route)
                }
        }
        .environmentObject(coordinator)
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.isDarkModeEnabled ? .dark : .light)
    }
}
