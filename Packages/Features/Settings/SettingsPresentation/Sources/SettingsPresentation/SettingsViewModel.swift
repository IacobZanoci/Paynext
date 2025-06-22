//
//  SettingsViewModel.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import Foundation
import Persistance
import LocalAuthentication

public final class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let persistenceStorage: UserDefaultsManagerProtocol
    
    // MARK: - Properties
    
    public var onLogout: () async -> Void
    public var onTogglePinAction: (Bool) -> Void
    @Published public var isOn: Bool = false
    @Published public var isFaceIdOn: Bool = false
    @Published public var isAuthenticateFaceId: Bool = false
    
    // MARK: - Titles
    
    @Published public var pinAccessButton: String = "Use PIN access"
    @Published public var faceIdLabel: String = "Use Face ID for app access"
    @Published public var alertTitle: String = "Face ID Unvailable"
    @Published public var alertMessage: String = "Face ID is not available or not enrolled on the device."
    @Published public var alertDismissButtonTitle: String = "OK"
    
    // MARK: - Initializers
    
    public init(
        persistenceStorage: UserDefaultsManagerProtocol,
        onLogout: @escaping () async -> Void,
        onTogglePinAction: @escaping (Bool) -> Void
    ) {
        self.persistenceStorage = persistenceStorage
        self.onLogout = onLogout
        self.onTogglePinAction = onTogglePinAction
        self.refreshPinStatus()
        
        NotificationCenter.default.addObserver(
            forName: .pinStatusChanged,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.refreshPinStatus()
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
        onTogglePinAction(toEnable)
    }
    
    public func onToggleFaceId(toEnable: Bool, completion: @escaping (Bool) -> Void) {
        guard isOn else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        let context = LAContext()
        var error: NSError?
        
        let isAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if isAvailable {
            let reason = toEnable ? "Enable Face ID for app access" : "Disable Face ID for app access"
            
            DispatchQueue.main.async {
                self.isAuthenticateFaceId = true
            }
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, _ in
                guard let self else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.isAuthenticateFaceId = false
                    if success {
                        self.isFaceIdOn = toEnable
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
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
