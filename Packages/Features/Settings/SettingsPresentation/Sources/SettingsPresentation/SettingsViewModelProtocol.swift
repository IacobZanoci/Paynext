//
//  SettingsViewModelProtocol.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import Foundation

@MainActor
public protocol SettingsViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var isOn: Bool { get set }
    var pinAccessButton: String { get }
    
    // MARK: - Actions
    
    func onLogout() async
    func onToggle(toEnable: Bool)
    func refreshPinStatus()
}
