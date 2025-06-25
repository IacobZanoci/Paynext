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
import AuthenticationPresentation

/// A top-level coordinator that manages app-wide navigation flows.
public final class AppCoordinator: Coordinator, ObservableObject {
    
    // MARK: - Properties
    
    /// Navigation path used for pushing views in a NavigationStack.
    @Published var navigationPath = NavigationPath()
    
    /// Current root route of the app.
    ///
    /// Changing this value replaces the base view in the NavigationStack.
    @Published var currentRoute: AppRoute = .login
    
    var lastActiveRoute: AppRoute? = nil
    var backgroundDate: Date? = nil
    private var persistentAuthViewModel: AuthenticationViewModel? = nil
    
    // MARK: - Initializers
    
    @MainActor
    init() {
        let isPinEnabled = UserDefaultsManager.shared.get(forKey: .isPinEnabled) ?? false
        let savedPin = UserDefaultsManager.shared.get(forKey: .paynextUserSecurePin) ?? ""
        if isPinEnabled && !savedPin.isEmpty {
            currentRoute = .enterPin
        } else {
            currentRoute = .login
        }
    }
    
    @MainActor
    func makePersistentAuthViewModel(
        flow: AuthenticationFlow,
        onSuccess: @escaping () -> Void
    ) -> AuthenticationViewModel {
        if let existing = persistentAuthViewModel {
            return existing
        }
        
        let vm = AuthenticationViewModel(
            flow: flow,
            onPinSuccess: {
                self.backgroundDate = nil
                onSuccess()
                self.persistentAuthViewModel = nil
            },
            onPin: {
                self.backgroundDate = nil
                onSuccess()
                self.persistentAuthViewModel = nil
            },
            launchedFromAppStart: false
        )
        self.persistentAuthViewModel = vm
        return vm
    }
    
    // MARK: - Navigation Methods
    
    /// Pushes a new view onto the NavigationStack.
    /// - Parameter route: The route to navigate to.
    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }
    
    /// Removes the last view from the NavigationStack.
    func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
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
    @MainActor
    func handleLogin() async {
        setRoot(to: .main)
    }
    
    @MainActor
    func createAuthenticationViewModel(
        flow: AuthenticationFlow,
        coordinator: AppCoordinator
    ) -> AuthenticationViewModel {
        let vm = AuthenticationViewModel(
            flow: flow,
            onPinSuccess: {
                Task {
                    coordinator.navigateBack()
                }
            },
            onPin: {
                Task {
                    await coordinator.handleLogin()
                }
            },
            launchedFromAppStart: true
        )
        return vm
    }
    
    @MainActor
    func view(
        route: AppRoute,
        coordinator: AppCoordinator
    ) -> some View {
        switch route {
        case .enterNewPin:
            return AnyView(
                AuthenticationView(
                    viewModel: createAuthenticationViewModel(
                        flow: .setupNewPin,
                        coordinator: coordinator
                    )
                )
            )
            
        case .disablePin:
            return AnyView(
                AuthenticationView(
                    viewModel: createAuthenticationViewModel(
                        flow: .disableFromSettings,
                        coordinator: coordinator
                    )
                )
            )
            
        case .enterPin:
            return AnyView(
                AuthenticationView(
                    viewModel: createAuthenticationViewModel(
                        flow: .authenticate,
                        coordinator: coordinator
                    )
                )
            )
            
        case .login:
            return AnyView(
                LoginView(
                    viewModel: LoginViewModel(
                        persistentStorage: UserDefaultsManager(),
                        onLogin: { await coordinator.handleLogin() },
                        credentialsValidator: CredentialsValidator()
                    )
                )
            )
            
        case .main:
            fatalError("MainTabView")
            
        case .enterPinAfterBackground:
            return AnyView(
                AuthenticationView(
                    viewModel: makePersistentAuthViewModel(flow: .authenticate) {
                        Task { @MainActor in
                            if let route = self.lastActiveRoute {
                                self.setRoot(to: route)
                            } else {
                                self.setRoot(to: .main)
                            }
                        }
                    }
                )
            )
        }
    }
}
