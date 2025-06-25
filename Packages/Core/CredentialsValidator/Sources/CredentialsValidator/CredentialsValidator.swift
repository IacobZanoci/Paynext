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
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{6}[0-9]{18,255}$")
        return predicate.evaluate(with: accountNumber)
    }
    
    public func isRoutingNumberValid(_ routingNumber: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{2}-[0-9]{7,255}$")
        return predicate.evaluate(with: routingNumber)
    }
    
    public func isAmountValid(_ amount: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", #"^\d{1,10}(\.\d{1,2})?$"#)
        return predicate.evaluate(with: amount)
    }
}
