//
//  AuthenticationViewModel.swift
//  AuthenticationPresentation
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import Foundation
import SwiftUI
import DesignSystem
import Persistance
import SettingsPresentation
@preconcurrency import LocalAuthentication

public enum AuthenticationEntryStep {
    case enterPin
    case disablePin
    case enterNewPin
    case confirmNewPin
}

public enum AuthenticationFlow {
    case authenticate
    case disableFromSettings
    case setupNewPin
}

public class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    // MARK: - Dependencies
    
    @Published public var currentStep: AuthenticationEntryStep
    private var flow: AuthenticationFlow
    
    // MARK: - Properties
    
    @Published public var focusedIndex: Int? = 0
    @Published public var showErrorAlert: Bool = false
    @Published public var pinNotMatchingError: Bool = false
    @Published public var pin: [String] = []
    private var faceIDEnabled: Bool = false
    public var onPinSuccess: (() -> Void)?
    public var onPin: (() -> Void)?
    private var firstEnteredPin: [String] = []
    private var launchedFromAppStart: Bool
    @Published public var isEnabled = UserDefaultsManager.shared.get(forKey: .isFaceIDOn) ?? false
    
    @Published public var selectedOption: Int = 0 {
        didSet {
            pin = Array(repeating: "", count: pinLength)
            focusedIndex = 0
        }
    }
    
    public var pinLength: Int {
        selectedOption == 0 ? 4 : 6
    }
    
    // MARK: - Titles
    
    public var titleText: String {
        switch currentStep {
        case .enterPin:
            return "Enter PIN"
        case .disablePin:
            return "Enter PIN"
        case .enterNewPin:
            return "Enter a new PIN"
        case .confirmNewPin:
            return  "Re-enter the new PIN"
        }
    }
    
    public var buttons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "Clear"]
    ]
    
    public var errorOrInfoText: String {
        switch currentStep {
        case .enterPin, .disablePin:
            return showErrorAlert
            ? "Wrong PIN. Please try again"
            : "Please enter your \(pinLength)-digits security PIN"
        case .enterNewPin:
            return pinNotMatchingError
            ? "PINs do not match. Please try again"
            : "Please enter your new \(pinLength)-digits security PIN"
        case .confirmNewPin:
            return "Please confirm your \(pinLength)-digits security PIN"
        }
    }
    
    public var errorTextColor: Color {
        if (showErrorAlert && (currentStep == .enterPin || currentStep == .disablePin)) ||
            (pinNotMatchingError && currentStep == .enterNewPin) {
            return Color.Paynext.errorStrokeBackground
        } else {
            return Color.Paynext.secondaryText
        }
    }
    
    // MARK: - Initializers
    
    public init(
        flow: AuthenticationFlow,
        onPinSuccess: (() -> Void)?,
        onPin: (() -> Void)?,
        launchedFromAppStart: Bool = false
    ) {
        self.flow = flow
        self.onPinSuccess = onPinSuccess
        self.onPin = onPin
        
        self.launchedFromAppStart = launchedFromAppStart
        let defaultSelectedOption = 0
        self.selectedOption = defaultSelectedOption
        self.pin = Array(repeating: "", count: defaultSelectedOption == 0 ? 4 : 6)
        
        switch flow {
        case .setupNewPin:
            self.currentStep = .enterNewPin
        case .authenticate:
            self.currentStep = .enterPin
        case .disableFromSettings:
            self.currentStep = .disablePin
        }
        
        let savedPin = UserDefaultsManager.shared.get(forKey: .paynextUserSecurePin) as String? ?? ""
        let pinCount = savedPin.count
        let selected = (flow == .authenticate || flow == .disableFromSettings) ? (pinCount == 6 ? 1 : 0) : 0
        let initialPinLength = selected == 0 ? 4 : 6
        
        self.selectedOption = selected
        self.pin = Array(repeating: "", count: initialPinLength)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshFaceIDStatus),
            name: .faceIDSettingsChanged,
            object: nil
        )
    }
    
    // MARK: - Deinitializers
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Events
    
    public func handleDigit(_ digit: String) {
        if (showErrorAlert || pinNotMatchingError), focusedIndex == 0 {
            showErrorAlert = false
            pinNotMatchingError = false
        }
        guard let index = focusedIndex, index < pinLength else { return }
        
        if pin[index].isEmpty {
            pin[index] = digit
            if index < pinLength - 1 {
                focusedIndex = index + 1
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.validatePinEntry()
                }
            }
        }
    }
    
    public func handleDelete() {
        if showErrorAlert { showErrorAlert = false }
        guard let index = focusedIndex else { return }
        if !pin[index].isEmpty {
            pin[index] = ""
        } else if index > 0 {
            focusedIndex = index - 1
            pin[index - 1] = ""
        }
    }
    
    public func resetState() {
        pin = Array(repeating: "", count: pinLength)
        firstEnteredPin = []
        focusedIndex = 0
        
        switch flow {
        case .setupNewPin:
            currentStep = .enterNewPin
        case .authenticate:
            currentStep = .enterPin
        case .disableFromSettings:
            currentStep = .disablePin
        }
    }
    
    public func cancelFlow() {
        onPinSuccess?()
    }
    
    // MARK: - Methods
    
    private func validatePinEntry() {
        let currentPin = Array(pin.prefix(pinLength))
        guard !currentPin.contains(where: { $0.isEmpty }) else { return }
        
        switch currentStep {
        case .enterPin:
            let savedPin = UserDefaultsManager.shared.get(forKey: .paynextUserSecurePin) as String? ?? ""
            if currentPin.joined() == savedPin {
                onPin?()
            } else {
                showErrorAlert = true
            }
        case .disablePin:
            let savedPin = UserDefaultsManager.shared.get(forKey: .paynextUserSecurePin) as String? ?? ""
            if currentPin.joined() == savedPin {
                UserDefaultsManager.shared.remove(forKey: .paynextUserSecurePin)
                UserDefaultsManager.shared.remove(forKey: .isPinEnabled)
                UserDefaultsManager.shared.remove(forKey: .isFaceIDOn)
                NotificationCenter.default.post(name: .pinStatusChanged, object: nil)
                NotificationCenter.default.post(name: .faceIDSettingsChanged, object: nil)
                onPinSuccess?()
            } else {
                showErrorAlert = true
            }
        case .enterNewPin:
            firstEnteredPin = currentPin
            pin = Array(repeating: "", count: pinLength)
            currentStep = .confirmNewPin
            focusedIndex = 0
        case .confirmNewPin:
            if currentPin == firstEnteredPin {
                let savedPin = currentPin.joined()
                UserDefaultsManager.shared.save(value: savedPin, forKey: .paynextUserSecurePin)
                UserDefaultsManager.shared.save(value: true, forKey: .isPinEnabled)
                //let check: Bool = UserDefaultsManager.shared.get(forKey: .isPinEnabled) ?? false
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: .pinStatusChanged, object: nil)
                onPinSuccess?()
                NotificationCenter.default.post(name: .pinStatusChanged, object: nil)
            } else {
                pinNotMatchingError = true
                pin = Array(repeating: "", count: pinLength)
                focusedIndex = 0
                currentStep = .enterNewPin
            }
        }
    }
    
    public func authenticateWithFaceID() {
        guard currentStep == .enterPin || currentStep == .disablePin else { return }
        guard UserDefaultsManager.shared.get(forKey: .isFaceIDOn) ?? false else { return }
        
        let context = LAContext()
        context.localizedFallbackTitle = ""
        context.interactionNotAllowed = false
        
        let reason = "Authenticate using Face ID"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                    DispatchQueue.main.async {
                        if success {
                            if self.currentStep == .disablePin {
                                self.disableSecurityDirectly()
                            } else {
                                self.launchedFromAppStart ? self.onPin?() : self.onPinSuccess?()
                            }
                        } else {
                            print("Biometric failed: \(evaluateError?.localizedDescription ?? "Unknown error")")
                        }
                    }
                }
            } else {
                print("Can't evaluate policy: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    @objc private func refreshFaceIDStatus() {
        let rawValue: Bool? = UserDefaultsManager.shared.get(forKey: .isFaceIDOn)
        self.faceIDEnabled = rawValue ?? false
    }
    
    private func disableSecurityDirectly() {
        UserDefaultsManager.shared.remove(forKey: .isFaceIDOn)
        NotificationCenter.default.post(name: .pinStatusChanged, object: nil)
        NotificationCenter.default.post(name: .faceIDSettingsChanged, object: nil)
        onPinSuccess?()
    }
}

public extension Notification.Name {
    static let faceIDSettingsChanged = Notification.Name("faceIDSettingsChanged")
}
