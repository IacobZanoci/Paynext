//
//  SettingsViewModelProtocol.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import Foundation

@MainActor
public protocol SettingsViewModelProtocol: ObservableObject {
    
    func onLogout() async
}
