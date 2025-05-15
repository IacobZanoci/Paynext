import XCTest
@testable import NetworkClient

final class NetworkClientTests: XCTestCase {
    
    // MARK: - Setup
    
    var mockSession: MockURLSession!
    var sut: NetworkClient!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = NetworkClient(urlSession: mockSession)
    }
    
    override func tearDown() {
        mockSession = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    // MARK: - Success Requests
    
    func test_givenValidURLAndMockResponse_whenGETRequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = "response".data(using: .utf8)!
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = expectedData
        mockSession.responseToReturn = HTTPURLResponse(url: url,
                                                       statusCode: 200,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        let data = try await sut.get(from: url)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenPOSTRequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data([1,2,3])
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = expectedData
        mockSession.responseToReturn = HTTPURLResponse(url: url,
                                                       statusCode: 201,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        let body: [String: String] = ["name": "Paynext"]
        
        let data = try await sut.post(to: url, body: body)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenPUTRequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data([9,8,7])
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = expectedData
        mockSession.responseToReturn = HTTPURLResponse(url: url,
                                                       statusCode: 200,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        let body: [String: Int] = ["id": 1]
        
        let data = try await sut.put(to: url, body: body)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenDELETERequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data()
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = expectedData
        mockSession.responseToReturn = HTTPURLResponse(url: url,
                                                       statusCode: 204,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        let data = try await sut.delete(from: url)
        XCTAssertEqual(data, expectedData)
    }
    
    // MARK: - Failure Requests
    
    func test_givenInvalidResponse_whenGETRequest_thenThrowsInvalidResponseError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = Data()
        mockSession.responseToReturn = URLResponse()
        
        do {
            let result = try await sut.get(from: url)
            XCTFail("Expected to throw 'invalidResponse' error, but got : \(result)")
        } catch {
            if case NetworkError.invalidResponse = error {
                //
            } else {
                XCTFail("Expected invalidResponse error, got: \(error)")
            }
        }
    }
    
    func test_givenHttpErrorResponse_whenGETRequest_thenThrowsHttpError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.dataToReturn = Data()
        mockSession.responseToReturn = HTTPURLResponse(url: url,
                                                       statusCode: 404,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        do {
            let result = try await sut.get(from: url)
            XCTFail("Expected to throw httpError, got: \(result)")
        } catch {
            if case let NetworkError.httpError(statusCode) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("Expected httpError with status 404, got: \(error)")
            }
        }
    }
    
    func test_givenTimeoutError_whenGETRequest_thenThrowsTimeoutError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.errorToThrow = URLError(.timedOut)
        
        do {
            let result = try await sut.get(from: url)
            XCTFail("Expected to throw timeoutError, got: \(result)")
        } catch {
            if case NetworkError.timeout = error {
            } else {
                XCTFail("Expected timeoutError, got: \(error)")
            }
        }
    }
    
    func test_givenRequestFailed_whenGETRequest_thenThrowsWrappedRequestFailedError() async {
        
        let url = URL(string: "https://paynext.com")!
        let underlyingError = NSError(domain: "paynextTestDomain", code: 1)
        
        mockSession.errorToThrow = underlyingError
        
        do {
            let result = try await sut.get(from: url)
            XCTFail("Expected to throw requestFailed error, got: \(result)")
        } catch {
            if case let NetworkError.requestFailed(inner) = error {
                XCTAssertEqual((inner as NSError).code, 1)
            } else {
                XCTFail("Expected requestFailed error, got: \(error)")
            }
        }
    }
    
    func test_givenEncodingErrorInPOSTRequest_whenPOSTRequestWithInvalidBody_thenThrowsEncodingError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        struct InvalidBody: Encodable {
            let url = URL(string: "invalid://")!
            func encode(to encoder: Encoder) throws {
                throw EncodingError.invalidValue(url, .init(codingPath: [], debugDescription: "PaynextTest"))
            }
        }
        
        do {
            let result = try await sut.post(to: url, body: InvalidBody())
            XCTFail("Expected to throw encodingError, got: \(result)")
        } catch {
            if case NetworkError.encodingError = error {
            } else {
                XCTFail("Expected encodingError error, got: \(error)")
            }
        }
    }
}
