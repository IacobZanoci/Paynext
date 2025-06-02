//
//  PaynextUser.swift
//  LoginDomain
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

public struct PaynextUser: Codable {
    
    public let userName: String
    public let accountNumber: String
    public let routingNumber: String
    
    public init(userName: String, accountNumber: String, routingNumber: String) {
        self.userName = userName
        self.accountNumber = accountNumber
        self.routingNumber = routingNumber
    }
}
