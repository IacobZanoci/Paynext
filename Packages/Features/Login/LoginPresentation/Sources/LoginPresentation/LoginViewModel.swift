//
//  LoginViewModel.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation
import Persistance
import LoginDomain
import CredentialsValidator

public class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public var isLoginDisabled: Bool = true
    @Published public var usernameValidationState: Bool = true
    @Published public var accountNumberValidationState: Bool = true
    @Published public var routingNumberValidationState: Bool = true
    private let persistentStorage: UserDefaultsManagerProtocol
    private let credentialsValidator: CredentialsValidatorProtocol
    private let onLogin: () async -> Void
    
    @Published public var userName: String = "" {
        didSet {
            validateUserName()
            updateLoginButtonState()
        }
    }
    
    @Published public var accountNumber: String = "" {
        didSet {
            validateAccountNumber()
            updateLoginButtonState()
        }
    }
    
    @Published public var routingNumber: String = "" {
        didSet {
            validateRoutingNumber()
            updateLoginButtonState()
        }
    }
    
    // MARK: - Titles
    
    @Published public var appIconTitle: String = "appIcon"
    @Published public var loginFormTitle: String = "Log in"
    @Published public var nameSurnameTitle: String = "Name and Surname"
    @Published public var accountNumberTitle: String = "Account Number"
    @Published public var routingNumberTitle: String = "Routing Number"
    @Published public var loginButtonTitle: String = "Log in"
    
    // MARK: - Placeholders
    
    @Published public var nameSurnamePlaceholder: String = "Enter name and surname"
    @Published public var accountNumberPlaceholder: String = "Enter account number"
    @Published public var routingNumberPlaceholder: String = "Enter routing number"
    
    // MARK: - Initializers
    
    public init(
        persistentStorage: UserDefaultsManagerProtocol,
        onLogin: @escaping () async -> Void,
        credentialsValidator: CredentialsValidatorProtocol
    ) {
        self.persistentStorage = persistentStorage
        self.onLogin = onLogin
        self.credentialsValidator = credentialsValidator
    }
    
    // MARK: - Methods
    
    private func validateUserName() {
        if userName.isEmpty || credentialsValidator.isNameValid(userName) {
            usernameValidationState = true
        } else {
            usernameValidationState = false
        }
    }
    
    private func validateAccountNumber() {
        if accountNumber.isEmpty || credentialsValidator.isAccountNumberValid(accountNumber) {
            accountNumberValidationState = true
        } else {
            accountNumberValidationState = false
        }
    }
    
    private func validateRoutingNumber() {
        if routingNumber.isEmpty || credentialsValidator.isRoutingNumberValid(routingNumber) {
            routingNumberValidationState = true
        } else {
            routingNumberValidationState = false
        }
    }
    
    private func updateLoginButtonState() {
        if credentialsValidator.isNameValid(userName) &&
            credentialsValidator.isAccountNumberValid(accountNumber) &&
            credentialsValidator.isRoutingNumberValid(routingNumber) {
            isLoginDisabled = false
        } else {
            isLoginDisabled = true
        }
    }
    
    private func saveUser(_ user: PaynextUser) {
        persistentStorage.save(value: user, forKey: .paynextUser)
    }
    
    // MARK: - Events
    
    public func onLogin() async {
        let user = PaynextUser(
            userName: userName,
            accountNumber: accountNumber,
            routingNumber: routingNumber
        )
        saveUser(user)
        
        await onLogin()
    }
}
