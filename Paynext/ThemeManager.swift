//
//  ThemeManager.swift
//  Paynext
//
//  Created by Iacob Zanoci on 13.06.2025.
//

import SwiftUI
import SettingsDomain

public final class ThemeManager: ObservableObject {
    
    // MARK: - Properties
    
    @AppStorage("isDarkModeEnabled") public var isDarkModeEnabled: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    // MARK: - Initializers
    
    public init() {}
}

// MARK: - Extensions

extension ThemeManager: ThemeManaging {}
