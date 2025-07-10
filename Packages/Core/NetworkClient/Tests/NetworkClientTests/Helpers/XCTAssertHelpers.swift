//
//  XCTAssertHelpers.swift
//  NetworkClient
//
//  Created by Iacob Zanoci on 10.07.2025.
//

import XCTest

/// Asserts that an `async` throwing expression throws an error.
///
/// Use this helper to test `async throws` methods, similar to `XCTAssertThrowsError` for synchronous code.
func XCTAssertThrowsAsync<T>(
    _ expression: @autoclosure @escaping () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        errorHandler(error)
    }
}
