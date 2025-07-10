//
//  SettingsViewModel.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import Foundation
import Persistance
import BiometricsAuth

@MainActor
public final class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let persistenceStorage: UserDefaultsManagerProtocol
    private let notificationCenter: NotificationCenterProtocol
    private let biometricsService: BiometricsServiceProtocol
    
    // MARK: - Properties
    
    private var pinObserver: NSObjectProtocol?
    private var faceIDObserver: NSObjectProtocol?
    
    public var onLogout: () async -> Void
    public var onTogglePinAction: (Bool) -> Void
    @Published public var isOn: Bool = false
    @Published public var isFaceIdOn: Bool = false
    @Published public var isAuthenticateFaceId: Bool = false
    @Published public var isRemoteSourceEnabled: Bool = false
    
    // MARK: - Titles
    
    @Published public var pinAccessButton: String = "Use PIN access"
    @Published public var faceIdLabel: String = "Use Face ID for app access"
    @Published public var alertTitle: String = "Face ID Unvailable"
    @Published public var alertMessage: String = "Face ID is not available or not enrolled on the device."
    @Published public var alertDismissButtonTitle: String = "OK"
    
    // MARK: - Initializers
    
    public init(
        persistenceStorage: UserDefaultsManagerProtocol,
        notificationCenter: NotificationCenterProtocol,
        biometricsService: BiometricsServiceProtocol,
        onLogout: @escaping () async -> Void,
        onTogglePinAction: @escaping (Bool) -> Void
    ) {
        self.persistenceStorage = persistenceStorage
        self.notificationCenter = notificationCenter
        self.biometricsService = biometricsService
        self.onLogout = onLogout
        self.onTogglePinAction = onTogglePinAction
        self.isRemoteSourceEnabled = persistenceStorage.get(forKey: .isRemoteSourceEnabled) ?? false
        
        refreshPinStatus()
        refreshFaceIDStatus()
        
        pinObserver = notificationCenter.addObserver(
            forName: .pinStatusChanged,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.refreshPinStatus()
            }
        }
        
        faceIDObserver = notificationCenter.addObserver(
            forName: .faceIDSettingsChanged,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.refreshFaceIDStatus()
            }
        }
    }
    
    // MARK: - Remove Observers
    
    public func cleanupObservers() {
        if let pinObserver = pinObserver {
            notificationCenter.removeObserver(pinObserver)
            self.pinObserver = nil
        }
        
        if let faceIDObserver = faceIDObserver {
            notificationCenter.removeObserver(faceIDObserver)
            self.faceIDObserver = nil
        }
    }
    
    // MARK: - Actions
    
    public func onLogout() async {
        cleanupObservers()
        persistenceStorage.remove(forKey: .paynextUser)
        await onLogout()
    }
    
    public func onToggle(toEnable: Bool) {
        isOn = toEnable
        onTogglePinAction(toEnable)
    }
    
    public func onToggleFaceId(toEnable: Bool, completion: @escaping (Bool) -> Void) {
        guard isOn else {
            completion(false)
            return
        }
        
        guard biometricsService.isBiometricAvailable() else {
            completion(false)
            return
        }
        
        isAuthenticateFaceId = true
        let reason = toEnable
        ? "Enable Face ID for app access"
        : "Disable Face ID for app access"
        
        biometricsService.authenticate(reason: reason) { [weak self] success in
            DispatchQueue.main.async {
                self?.isAuthenticateFaceId = false
                if success {
                    self?.isFaceIdOn = toEnable
                    self?.biometricsService.setFaceIDEnabled(toEnable)
                }
                completion(success)
            }
        }
    }
    
    public func refreshPinStatus() {
        let pin: String? = persistenceStorage.get(forKey: .paynextUserSecurePin)
        self.isOn = pin != nil
    }
    
    public func refreshFaceIDStatus() {
        self.isFaceIdOn = biometricsService.isFaceIDEnabled
    }
    
    // MARK: - Remote Transactions Source
    
    public func toggleTransactionSource(toRemote: Bool) {
        isRemoteSourceEnabled = toRemote
        persistenceStorage.save(value: toRemote, forKey: .isRemoteSourceEnabled)
    }
}
