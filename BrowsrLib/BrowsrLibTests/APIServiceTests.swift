//
//  APIServiceTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/16/23.
//

import XCTest
@testable import BrowsrLib

class APIServiceTests: XCTestCase {
    //
    //    var sut: APIService!
    //    var mockSession: URLSessionMock!
    //
    //    override func setUp() {
    //        super.setUp()
    //        mockSession = URLSessionMock()
    //        sut = APIService(session: mockSession)
    //    }
    //
    //    override func tearDown() {
    //        sut = nil
    //        mockSession = nil
    //        super.tearDown()
    //    }
    //
    //    func testRequestSuccess() {
    //        // given
    //        let endpoint = MockEndpoint.success
    //        let expectedData = MockResponse.data
    //        mockSession.nextData = expectedData
    //        mockSession.nextResponse = HTTPURLResponse(url: endpoint.url,
    //                                                    statusCode: 200,
    //                                                    httpVersion: nil,
    //                                                    headerFields: nil)
    //        // when
    //        var actualData: Data?
    //        var actualError: Error?
    //        let expectation = self.expectation(description: "Expect API call to complete")
    //        sut.request(endpoint) { result in
    //            switch result {
    //            case .success(let data):
    //                actualData = data as? Data
    //            case .failure(let error):
    //                actualError = error
    //            }
    //            expectation.fulfill()
    //        }
    //        waitForExpectations(timeout: 1.0, handler: nil)
    //
    //        // then
    //        XCTAssertNotNil(actualData, "Actual data should not be nil")
    //        XCTAssertEqual(actualData, expectedData, "Actual data should match expected data")
    //        XCTAssertNil(actualError, "Actual error should be nil")
    //    }
    //
    //    func testRequestFailure() {
    //        // given
    //        let endpoint = MockEndpoint.failure
    //        mockSession.nextResponse = HTTPURLResponse(url: endpoint.url,
    //                                                    statusCode: 404,
    //                                                    httpVersion: nil,
    //                                                    headerFields: nil)
    //
    //        // when
    //        var actualData: Data?
    //        var actualError: Error?
    //        let expectation = self.expectation(description: "Expect API call to complete")
    //        sut.request(endpoint) { result in
    //            switch result {
    //            case .success(let data):
    //                actualData = data as? Data
    //            case .failure(let error):
    //                actualError = error
    //            }
    //            expectation.fulfill()
    //        }
    //        waitForExpectations(timeout: 1.0, handler: nil)
    //
    //        // then
    //        XCTAssertNil(actualData, "Actual data should be nil")
    //        XCTAssertNotNil(actualError, "Actual error should not be nil")
    //    }
}
