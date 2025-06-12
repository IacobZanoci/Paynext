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
    
    // MARK: - Properties
    
    private let persistenceStorage: UserDefaultsManagerProtocol
    private let onLogout: () async -> Void
    
    // MARK: - Initializers
    
    public init(
        persistenceStorage: UserDefaultsManagerProtocol,
        onLogout: @escaping () async -> Void
    ) {
        self.persistenceStorage = persistenceStorage
        self.onLogout = onLogout
    }
    
    // MARK: - Methods
    
    private func removeLoginUser() {
        persistenceStorage.remove(forKey: .paynextUser)
    }
    
    public func onLogout() async {
        removeLoginUser()
        await onLogout()
    }
}
