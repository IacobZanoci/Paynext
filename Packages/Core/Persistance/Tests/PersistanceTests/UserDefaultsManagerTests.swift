//
//  UserDefaultsManagerTests.swift
//  Persistance
//
//  Created by Iacob Zanoci on 28.05.2025.
//

import XCTest
@testable import Persistance

final class UserDefaultsManagerTests: XCTestCase {
    
    // MARK: - Test Setup
    
    var sut: UserDefaultsManager!
    var testKey: UserDefaultsKey = .paynextUser
    
    override func setUp() {
        super.setUp()
        sut = UserDefaultsManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_givenSavedString_whenGetIsCalled_thenReturnsSavedString() {
        sut.save(value: "PaynextValue", forKey: testKey)
        let retrieved: String? = sut.get(forKey: testKey)
        XCTAssertEqual(retrieved, "PaynextValue")
    }
    
    func test_giveSavedInt_whenGetIsCalled_thenReturnsSavedInt() {
        sut.save(value: 111, forKey: testKey)
        let retrieved: Int? = sut.get(forKey: testKey)
        XCTAssertEqual(retrieved, 111)
    }
    
    func test_givenSaveBool_whenGetIsCalled_thenReturnsSavedBool() {
        sut.save(value: true, forKey: testKey)
        let retrieved: Bool? = sut.get(forKey: testKey)
        XCTAssertEqual(retrieved, true)
    }
    
    func test_givenSaveValue_whenRemoveIsCalled_thenValueIsNil() {
        sut.save(value: "Paynext", forKey: testKey)
        sut.remove(forKey: testKey)
        let value: String? = sut.get(forKey: testKey)
        XCTAssertNil(value)
    }
    
    func test_givenSaveValue_whenExistsIsCalled_thenReturnsTrue() {
        sut.save(value: "Paynext", forKey: testKey)
        XCTAssertTrue(sut.exists(key: testKey))
    }
    
    func test_givenNoValueSaved_whenExistsIsCalled_thenReturnsFalse() {
        XCTAssertFalse(sut.exists(key: testKey))
    }
}
