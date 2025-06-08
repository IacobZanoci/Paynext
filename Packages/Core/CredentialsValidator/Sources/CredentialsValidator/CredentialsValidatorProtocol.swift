//
//  CredentialsValidatorProtocol.swift
//  CredentialsValidator
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation

public protocol CredentialsValidatorProtocol {
    
    func isNameValid(_ name: String) -> Bool
    func isAccountNumberValid(_ accountNumber: String) -> Bool
    func isRoutingNumberValid(_ routingNumber: String) -> Bool
    func isAmountValid(_ amount: String) -> Bool
}
