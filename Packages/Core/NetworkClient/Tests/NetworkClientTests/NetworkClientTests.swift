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
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!
        
        mockSession.result = .success((expectedData, response))
        
        let data = try await sut.get(from: url)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenPOSTRequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data([1,2,3])
        let url = URL(string: "https://paynext.com")!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 201,
                                       httpVersion: nil,
                                       headerFields: nil)!
        let body: [String: String] = ["name": "Paynext"]
        
        mockSession.result = .success((expectedData, response))
        
        let data = try await sut.post(to: url, body: body)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenPUTRequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data([9,8,7])
        let url = URL(string: "https://paynext.com")!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!
        let body: [String: Int] = ["id": 1]
        
        mockSession.result = .success((expectedData, response))
        
        let data = try await sut.put(to: url, body: body)
        XCTAssertEqual(data, expectedData)
    }
    
    func test_givenValidURLAndMockResponse_whenDELETERequestSucceeds_thenReturnsExpectedData() async throws {
        
        let expectedData = Data()
        let url = URL(string: "https://paynext.com")!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 204,
                                       httpVersion: nil,
                                       headerFields: nil)!
        
        mockSession.result = .success((expectedData, response))
        
        let data = try await sut.delete(from: url)
        XCTAssertEqual(data, expectedData)
    }
    
    // MARK: - Failure Requests
    
    func test_givenInvalidResponse_whenGETRequest_thenThrowsInvalidResponseError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.result = .success((Data(), URLResponse()))
        
        do {
            _ = try await sut.get(from: url)
            XCTFail("Expected to throw NetworkError.invalidResponse")
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidResponse)
        }
    }
    
    func test_givenHttpErrorResponse_whenGETRequest_thenThrowsHttpError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.result = .success((
            Data(),
            HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
        ))
        
        await XCTAssertThrowsAsync(try await self.sut.get(from: url)) { error in
            if case let NetworkError.httpError(statusCode) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("Expected httpError with status 404, got: \(error)")
            }
        }
    }
    
    func test_givenTimeoutError_whenGETRequest_thenThrowsTimeoutError() async {
        
        let url = URL(string: "https://paynext.com")!
        
        mockSession.result = .failure(URLError(.timedOut))
        
        await XCTAssertThrowsAsync(try await self.sut.get(from: url)) { error in
            XCTAssertEqual(error as? NetworkError, .timeout)
        }
    }
    
    func test_givenRequestFailed_whenGETRequest_thenThrowsWrappedRequestFailedError() async {
        
        let url = URL(string: "https://paynext.com")!
        let underlyingError = NSError(domain: "paynextTestDomain", code: 1)
        
        mockSession.result = .failure(underlyingError)
        
        await XCTAssertThrowsAsync(try await self.sut.get(from: url)) { error in
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
        
        await XCTAssertThrowsAsync(try await self.sut.post(to: url, body: InvalidBody())) { error in
            XCTAssertEqual(error as? NetworkError, .encodingError)
        }
    }
}
