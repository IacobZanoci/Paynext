//
//  StaticTransactionAPIConfig.swift
//  Transaction
//
//  Created by Iacob Zanoci on 09.07.2025.
//

import Foundation

public final class StaticTransactionAPIConfig: TransactionAPIConfig {
    
    // MARK: - Properties
    
    public let baseURL: URL = URL(string: "https://paynext.com")!
    public let token: String = "paynext-authentication-token-sample"
    
    // MARK: - Initializers
    
    public init() {}
}
