//
//  NotificationCenterProtocol.swift
//  BiometricsAuth
//
//  Created by Iacob Zanoci on 23.06.2025.
//

import Foundation

public protocol NotificationCenterProtocol {
    
    func addObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @Sendable @escaping (Notification) -> Void
    ) -> NSObjectProtocol
    
    func removeObserver(_ observer: Any)
    func post(name aName: NSNotification.Name, object anObject: Any?)
}

extension NotificationCenter: NotificationCenterProtocol {}
