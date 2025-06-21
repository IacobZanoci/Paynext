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
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        
        Group {
            switch appCoordinator.currentRoute {
            case .main:
                MainTabView(coordinator: appCoordinator)
                
            default:
                NavigationStack(path: $appCoordinator.navigationPath) {
                    appCoordinator.view(route: appCoordinator.currentRoute, coordinator: appCoordinator)
                        .navigationDestination(for: AppRoute.self) { route in
                            appCoordinator.view(route: route, coordinator: appCoordinator)
                        }
                }
            }
        }
        .preferredColorScheme(themeManager.isDarkModeEnabled ? .dark : .light)
    }
}
