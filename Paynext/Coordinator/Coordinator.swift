//
//  Coordinator.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    
    var navigationPath: NavigationPath { get set }
    func navigate(to destination: AppRoute)
    func navigateBack()
    func navigateToRoot()
}
