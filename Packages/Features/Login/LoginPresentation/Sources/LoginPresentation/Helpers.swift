//
//  Helpers.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import SwiftUI
import Combine

public extension Publishers {
    
    static var keyboardVisible: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
