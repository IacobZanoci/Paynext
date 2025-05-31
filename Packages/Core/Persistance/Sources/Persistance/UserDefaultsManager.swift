//
//  UserDefaultsManager.swift
//  Persistance
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: - Properties
    
    @MainActor static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    // MARK: - Inititalizers
    
    public init () {}
    
    // MARK: - Save
    
    public func save<T>(value: T, forKey key: UserDefaultsKey) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    // MARK: - Read
    
    public func get<T>(forKey key: UserDefaultsKey) -> T? {
        return defaults.value(forKey: key.rawValue) as? T
    }
    
    // MARK: - Remove
    
    public func remove(forKey key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    // MARK: - Exists
    
    public func exists(key: UserDefaultsKey) -> Bool {
        return defaults.object(forKey: key.rawValue) != nil
    }
}
