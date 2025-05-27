//
//  AppCoordinator.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

import SwiftUI

@Observable
final class AppCoordinator: Coordinator {
    
    var navigationPath = NavigationPath()
    
    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        /// Define all app routes
        /// ...
        /// switch route {
        ///     case .applyFilters:
        ///     ApplyFiltersView()
        /// }
    }
}
