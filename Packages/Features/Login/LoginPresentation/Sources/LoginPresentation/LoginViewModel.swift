//
//  LoginViewModel.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

public class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public var isLoginDisabled: Bool = true
    @Published public var usernameValidationState: Bool = true
    @Published public var accountNumberValidationState: Bool = true
    @Published public var routingNumberValidationState: Bool = true
    
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
    
    public init() {}
    
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
    
    public func onLogin() {
        print("Tapped `Log in` button")
    }
}
