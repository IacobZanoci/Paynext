//
//  CredentialsValidator.swift
//  CredentialsValidator
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation

public class CredentialsValidator: CredentialsValidatorProtocol {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Methods
    
    public func isNameValid(_ name: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z ]{4,225}$")
        return predicate.evaluate(with: name)
    }
    
    public func isAccountNumberValid(_ accountNumber: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{18,24}$")
        return predicate.evaluate(with: accountNumber)
    }
    
    public func isRoutingNumberValid(_ routingNumber: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{2}-[0-9]{7,9}$")
        return predicate.evaluate(with: routingNumber)
    }
    
    public func isAmountValid(_ amount: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", #"^\d+(\.\d{2})?$"#)
        return predicate.evaluate(with: amount)
    }
}
