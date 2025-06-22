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
    var isFaceIdOn: Bool { get set }
    var isAuthenticateFaceId: Bool { get set }
    
    // MARK: - Titles
    
    var pinAccessButton: String { get }
    var faceIdLabel: String { get }
    var alertTitle: String { get }
    var alertMessage: String { get }
    var alertDismissButtonTitle: String { get }
    
    // MARK: - Actions
    
    func onLogout() async
    func onToggle(toEnable: Bool)
    func refreshPinStatus()
    func onToggleFaceId(toEnable: Bool, completion: @escaping (Bool) -> Void)
}
