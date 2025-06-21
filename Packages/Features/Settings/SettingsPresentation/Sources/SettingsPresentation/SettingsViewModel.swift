//
//  SettingsViewModel.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import Foundation
import Persistance

@MainActor
public final class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let persistenceStorage: UserDefaultsManagerProtocol
    
    // MARK: - Properties
    
    public var onLogout: () async -> Void
    public var onToggleAction: (Bool) -> Void
    @Published public var isOn: Bool = false
    @Published public var pinAccessButton: String = "Use PIN access"
    
    // MARK: - Initializers
    
    public init(
        persistenceStorage: UserDefaultsManagerProtocol,
        onLogout: @escaping () async -> Void,
        onToggleAction: @escaping (Bool) -> Void
    ) {
        self.persistenceStorage = persistenceStorage
        self.onLogout = onLogout
        self.onToggleAction = onToggleAction
        self.refreshPinStatus()
        
        NotificationCenter.default.addObserver(
            forName: .pinStatusChanged,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.refreshPinStatus()
            }
        }
    }
    
    // MARK: - Deinitializers
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    public func onLogout() async {
        persistenceStorage.remove(forKey: .paynextUser)
        await onLogout()
    }
    
    public func onToggle(toEnable: Bool) {
        onToggleAction(toEnable)
    }
    
    public func refreshPinStatus() {
        let pin: String? = UserDefaultsManager.shared.get(forKey: .paynextUserSecurePin)
        self.isOn = pin != nil
    }
}

// MARK: - Extensions

public extension Notification.Name {
    static let pinStatusChanged = Notification.Name("pinStatusChanged")
}
