//
//  BiometricsService.swift
//  BiometricsAuth
//
//  Created by Iacob Zanoci on 23.06.2025.
//

import Foundation
import LocalAuthentication
import Persistance

public final class BiometricsService: BiometricsServiceProtocol {
    
    // MARK: - Dependencies
    
    private let storage: UserDefaultsManagerProtocol
    private let notificationCenter: NotificationCenterProtocol
    
    // MARK: - Init
    
    public init(
        storage: UserDefaultsManagerProtocol,
        notificationCenter: NotificationCenterProtocol
    ) {
        self.storage = storage
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - Properties
    
    public var isFaceIDEnabled: Bool {
        storage.get(forKey: .isFaceIDOn) ?? false
    }
    
    // MARK: - Methods
    
    public func isBiometricAvailable() -> Bool {
        var error: NSError?
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    public func authenticate(reason: String, completion: @escaping (Bool) -> Void) {
#if targetEnvironment(simulator)
        completion(true)
#else
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false)
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            completion(success)
        }
#endif
    }
    
    public func setFaceIDEnabled(_ enabled: Bool) {
        if enabled {
            storage.save(value: true, forKey: .isFaceIDOn)
        } else {
            storage.remove(forKey: .isFaceIDOn)
        }
        notificationCenter.post(name: .faceIDSettingsChanged, object: nil)
    }
}
