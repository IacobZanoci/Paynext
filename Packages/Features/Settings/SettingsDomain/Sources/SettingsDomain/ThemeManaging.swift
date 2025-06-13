//
//  ThemeManaging.swift
//  SettingsDomain
//
//  Created by Iacob Zanoci on 13.06.2025.
//

import Foundation

public protocol ThemeManaging: ObservableObject {
    
    var isDarkModeEnabled: Bool { get set }
}
