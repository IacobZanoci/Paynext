//
//  Route.swift
//  Paynext
//
//  Created by Iacob Zanoci on 27.05.2025.
//

protocol Route: Hashable {}

enum AppRoute: Route {
    
    case login
    case main
}
