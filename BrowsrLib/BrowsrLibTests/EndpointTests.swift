//
//  EndpointTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/16/23.
//

import XCTest
@testable import BrowsrLib

class EndpointTests: XCTestCase {
    func testListOrganizationsEndpoint() {
        let endpoint = GitHubEndpoint.listOrganizations(page: 1, perPage: 10)
        let request = endpoint.request()
        // Check the URL
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/organizations?page=1&per_page=10")
        // Check the HTTP method
        XCTAssertEqual(request.httpMethod, "GET")
        // Check the headers
        XCTAssertNil(request.allHTTPHeaderFields?["Content-Type"])
        // Check the parameters
        XCTAssertNil(request.httpBody)
    }
    
    func testSearchOrganizationsEndpoint() {
        let endpoint = GitHubEndpoint.searchOrganizations(query: "apple")
        let request = endpoint.request()
        // Check the URL
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/search/users?q=apple+type:org")
        // Check the HTTP method
        XCTAssertEqual(request.httpMethod, "GET")
        // Check the headers
        XCTAssertNil(request.allHTTPHeaderFields?["Content-Type"])
        // Check the parameters
        XCTAssertNil(request.httpBody)
    }

    func testRequestParameters() {
        let endpoint = GitHubEndpoint.searchOrganizations(query: "apple")
        let request = endpoint.request()
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/search/users?q=apple+type:org")
    }
}
