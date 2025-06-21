//
//  PaynextApp.swift
//  Paynext
//
//  Created by Iacob Zanoci on 10.05.2025.
//

import SwiftUI
import AuthenticationPresentation

@main
struct PaynextApp: App {
    
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appCoordinator)
                .environmentObject(themeManager)
        }
    }
}
