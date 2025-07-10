//
//  File.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 10.07.2025.
//

import Foundation
import SettingsDomain

final class MockThemeManager: ThemeManaging, ObservableObject {
    @Published var isDarkModeEnabled: Bool = false
}
