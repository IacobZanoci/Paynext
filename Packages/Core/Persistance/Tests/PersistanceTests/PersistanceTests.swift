import XCTest
@testable import Persistance

final class PersistanceTests: XCTestCase {
    
    // MARK: - Set Up
    
    var sut: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataManager(inMemory: true)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_givenUserEntityWithToken_whenSaveAndFetch_thenReturnsEntityWithSameToken() throws {
        let entity = sut.create(type: User.self)
        entity.token = "paynextToken"
        try sut.saveContext()
        
        let result = try sut.fetch(type: User.self)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.token, "paynextToken")
    }
    
    func test_givenUserEntity_whenDeleteAndContextSave_thenEntityIsNotFethced() throws {
        let entity = sut.create(type: User.self)
        entity.token = "paynextToken"
        sut.delete(entity)
        try sut.saveContext()
        
        let result = try sut.fetch(type: User.self)
        
        XCTAssertEqual(result.count, 0)
    }
}
