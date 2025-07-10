//
//  TransactionAPIConfig.swift
//  Transaction
//
//  Created by Iacob Zanoci on 09.07.2025.
//

import Foundation

public protocol TransactionAPIConfig {
    
    var baseURL: URL { get }
    var token: String { get }
}
