//
//  UserDefaultsManager.swift
//  Persistance
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import Foundation

public class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    // MARK: - Properties
    
    @MainActor static public let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    // MARK: - Inititalizers
    
    public init () {}
    
    // MARK: - Save
    
    public func save<T: Codable>(value: T, forKey key: UserDefaultsKey) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(value) {
            defaults.set(data, forKey: key.rawValue)
        }
    }
    
    // MARK: - Read
    
    public func get<T: Codable>(forKey key: UserDefaultsKey) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
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
