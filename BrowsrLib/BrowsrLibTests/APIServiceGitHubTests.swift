//
//  APIServiceGitHubTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/17/23.
//

import XCTest
@testable import BrowsrLib

class APIServiceGitHubTests: XCTestCase {
    func testGetOrganizations() {
        // Create an instance of APIService with a real URLSession
        let apiService = APIService()
        // Create an expectation for the API response
        let expectation = XCTestExpectation(description: "API response")
        // Call the GitHub organizations endpoint
        let endpoint = GitHubEndpoint.listOrganizations
        apiService.request(endpoint) { (result: Result<Organizations, Error>) in
            switch result {
            case .success(let organizations):
                // Check that at least one organization was returned
                XCTAssertGreaterThan(organizations.count, 0)
            case .failure(let error):
                XCTFail("API request failed with error: \(error)")
            }
            // Fulfill the expectation
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}
