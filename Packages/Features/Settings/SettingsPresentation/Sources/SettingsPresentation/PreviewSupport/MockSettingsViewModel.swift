//
//  MockSettingsViewModel.swift
//  SettingsPresentation
//
//  Created by Iacob Zanoci on 10.07.2025.
//

import Foundation

final class MockSettingsViewModel: SettingsViewModelProtocol, ObservableObject {
    @Published var isOn: Bool = true
    @Published var isFaceIdOn: Bool = false
    @Published var isAuthenticateFaceId: Bool = false
    @Published var isRemoteSourceEnabled: Bool = true
    
    var pinAccessButton: String = "Use PIN"
    var faceIdLabel: String = "Use Face ID"
    var alertTitle: String = "Face ID Error"
    var alertMessage: String = "Unable to enable Face ID."
    var alertDismissButtonTitle: String = "OK"
    
    func onLogout() async {}
    func onToggle(toEnable: Bool) { isOn = toEnable }
    func refreshPinStatus() {}
    func onToggleFaceId(toEnable: Bool, completion: @escaping (Bool) -> Void) {
        isFaceIdOn = toEnable
        completion(true)
    }
    func cleanupObservers() {}
    func toggleTransactionSource(toRemote: Bool) {
        isRemoteSourceEnabled = toRemote
    }
}
