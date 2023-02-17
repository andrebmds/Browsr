//
//  EndpointTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/16/23.
//

import XCTest
@testable import BrowsrLib

class EndpointTests: XCTestCase {
    func testRequestURL() {
        let endpoint = GitHubEndpoint.listOrganizations
        let request = endpoint.request()
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/organizations")
    }
    
    func testRequestMethod() {
        let endpoint = GitHubEndpoint.listOrganizations
        let request = endpoint.request()
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testRequestParameters() {
        let endpoint = GitHubEndpoint.searchOrganizations(query: "apple")
        let request = endpoint.request()
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/search/orgs?q=apple")
    }
    
    func testOrganizationEndpoint() {
        let endpoint = GitHubEndpoint.listOrganizations
        let request = endpoint.request()
        // Check the URL
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/organizations")
        // Check the HTTP method
        XCTAssertEqual(request.httpMethod, "GET")
        // Check the headers
        XCTAssertNil(request.allHTTPHeaderFields?["Content-Type"])
        // Check the parameters
        XCTAssertNil(request.httpBody)
    }
}
