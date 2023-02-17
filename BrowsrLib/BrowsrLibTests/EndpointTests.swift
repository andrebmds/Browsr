//
//  EndpointTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/16/23.
//

import XCTest
@testable import BrowsrLib

class EndpointTests: XCTestCase {
    func testRequest() {
        let endpoint = EndpoinMock()
        let request = endpoint.request()
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/organizations/path")
        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(request.allHTTPHeaderFields, ["Authorization": "Bearer token"])
    }
}

struct EndpoinMock: Endpoint {
    var path: String { "/path" }
    var method: HTTPMethod { .get }
    var parameters: [String: Any]? { nil }
    var headers: [String: String]? { ["Authorization": "Bearer token"] }
}
