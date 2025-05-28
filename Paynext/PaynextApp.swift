//
//  PaynextApp.swift
//  Paynext
//
//  Created by Iacob Zanoci on 10.05.2025.
//

import SwiftUI

@main
struct PaynextApp: App {
    
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}
