//
//  BiometricsServiceProtocol.swift
//  BiometricsAuth
//
//  Created by Iacob Zanoci on 23.06.2025.
//

import Foundation

public protocol BiometricsServiceProtocol {
    
    // MARK: - Properties
    
    var isFaceIDEnabled: Bool { get }
    
    // MARK: - Methods
    
    func isBiometricAvailable() -> Bool
    func authenticate(reason: String, completion: @escaping (Bool) -> Void)
    func setFaceIDEnabled(_ enabled: Bool)
}
