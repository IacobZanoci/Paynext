//
//  LoginValidator.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

struct LoginValidator {
    
    // MARK: - User Name Validation
    
    static func isUserNameValid(_ userName: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z ]{4,225}$")
        return predicate.evaluate(with: userName)
    }
    
    // MARK: - Account Number Validation
    
    static func isAccountNumberValid(_ accountNumber: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{18,24}$")
        return predicate.evaluate(with: accountNumber)
    }
    
    // MARK: - Routing Number Validation
    
    static func isRoutingNumberValid(_ routingNumber: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z]{2}-[0-9]{7,9}$")
        return predicate.evaluate(with: routingNumber)
    }
}
