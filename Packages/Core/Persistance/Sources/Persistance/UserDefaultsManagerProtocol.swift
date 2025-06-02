//
//  UserDefaultsManagerProtocol.swift
//  Persistance
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

public protocol UserDefaultsManagerProtocol {
    func save<T: Codable>(value: T, forKey key: UserDefaultsKey)
    func get<T: Codable>(forKey key: UserDefaultsKey) -> T?
    func remove(forKey key: UserDefaultsKey)
    func exists(key: UserDefaultsKey) -> Bool
}
