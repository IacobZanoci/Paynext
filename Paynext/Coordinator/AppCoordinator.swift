//
//  AppCoordinator.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

import SwiftUI
import LoginPresentation
import Persistance
import CredentialsValidator

/// A top-level coordinator that manages app-wide navigation flows.
public final class AppCoordinator: Coordinator, ObservableObject {
    
    // MARK: - Properties
    
    /// Navigation path used for pushing views in a NavigationStack.
    @Published var navigationPath = NavigationPath()
    
    /// Current root route of the app.
    ///
    /// Changing this value replaces the base view in the NavigationStack.
    @Published var currentRoute: AppRoute = .login
    
    // MARK: - Navigation Methods
    
    /// Pushes a new view onto the NavigationStack.
    /// - Parameter route: The route to navigate to.
    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }
    
    /// Removes the last view from the NavigationStack.
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    /// Removes all pushed views but keeps the current root view.
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    /// Clears the entire NavigationStack and sets a new root view.
    /// - Parameter route: The new root route to display.
    @MainActor
    func setRoot(to route: AppRoute) {
        navigationPath = NavigationPath()
        currentRoute = route
    }
    
    /// Handles the login flow and sets the root to the main view.
    func handleLogin() async {
        await self.setRoot(to: .main)
    }
    
    /// Builds and returns the view associated with a given app route.
    @MainActor @ViewBuilder
    func view(route: AppRoute) -> some View {
        switch route {
        case .login:
            LoginView(
                viewModel: LoginViewModel(
                    persistentStorage: UserDefaultsManager(),
                    onLogin: { await self.handleLogin() },
                    credentialsValidator: CredentialsValidator()
                )
            )
            
        case .main:
            MainTabView()
        }
    }
}
