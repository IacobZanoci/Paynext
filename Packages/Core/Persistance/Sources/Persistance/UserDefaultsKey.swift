//
//  UserDefaultsKey.swift
//  Persistance
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import Foundation

public enum UserDefaultsKey: String {
    
    // MARK: - User Credentials
    
    case paynextUser
    case paynextUserSecurePin
    case securePinLength
    
    // MARK: - Authentication
    
    case isFaceIDOn
    case isPinEnabled
    
    // MARK: - App appearance
    
    case isDarkModeEnabled
    
    // MARK: - Remote Transactions Source
    
    case isRemoteSourceEnabled
}
