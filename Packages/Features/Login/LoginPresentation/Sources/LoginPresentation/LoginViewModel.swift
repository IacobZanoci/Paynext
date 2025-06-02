//
//  LoginViewModel.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation
import Persistance
import LoginDomain

public class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public var isLoginDisabled: Bool = true
    @Published public var usernameValidationState: Bool = true
    @Published public var accountNumberValidationState: Bool = true
    @Published public var routingNumberValidationState: Bool = true
    private let persistentStorage: UserDefaultsManagerProtocol
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
    
    // MARK: - Initializers
    
    public init(
        persistentStorage: UserDefaultsManagerProtocol,
        onLogin: @escaping () async -> Void
    ) {
        self.persistentStorage = persistentStorage
        self.onLogin = onLogin
    }
    
    // MARK: - Methods
    
    private func validateUserName() {
        if userName.isEmpty || LoginValidator.isUserNameValid(userName) {
            usernameValidationState = true
        } else {
            usernameValidationState = false
        }
    }
    
    private func validateAccountNumber() {
        if accountNumber.isEmpty || LoginValidator.isAccountNumberValid(accountNumber) {
            accountNumberValidationState = true
        } else {
            accountNumberValidationState = false
        }
    }
    
    private func validateRoutingNumber() {
        if routingNumber.isEmpty || LoginValidator.isRoutingNumberValid(routingNumber) {
            routingNumberValidationState = true
        } else {
            routingNumberValidationState = false
        }
    }
    
    private func updateLoginButtonState() {
        if LoginValidator.isUserNameValid(userName) &&
            LoginValidator.isAccountNumberValid(accountNumber) &&
            LoginValidator.isRoutingNumberValid(routingNumber) {
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
        print("Tapped `Log in` button")
        
        let user = PaynextUser(
            userName: userName,
            accountNumber: accountNumber,
            routingNumber: routingNumber
        )
        saveUser(user)
        
        await onLogin()
    }
}
