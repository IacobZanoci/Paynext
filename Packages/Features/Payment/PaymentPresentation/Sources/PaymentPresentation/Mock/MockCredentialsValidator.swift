//
//  MockCredentialsValidator.swift
//  PaymentPresentation
//
//  Created by Iacob Zanoci on 08.06.2025.
//

import Foundation
import CredentialsValidator

final class MockCredentialsValidator: CredentialsValidatorProtocol {
    func isNameValid(_ name: String) -> Bool { true }
    func isAccountNumberValid(_ number: String) -> Bool { true }
    func isRoutingNumberValid(_ number: String) -> Bool { true }
    func isAmountValid(_ amount: String) -> Bool { true }
}
