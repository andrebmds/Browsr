//
//  APIServiceGitHubTests.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/17/23.
//

import XCTest
@testable import BrowsrLib

class APIServiceGitHubTests: XCTestCase {
    var sut: GithubAPI!
    override func setUp() {
        super.setUp()
        sut = GithubAPI()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func testGetOrganizationsMock() {
        let expectation = self.expectation(description: "Get organizations")
        
        sut.getOrganizations { result in
            switch result {
            case .success(let organizations):
                XCTAssertNotNil(organizations, "Organizations should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get organizations: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testGetOrganizationsSuccess() {
        let mock = MockGithubAPI(responseData: .validData)
        let expectation = XCTestExpectation(description: "Completion called")
        
        mock.getOrganizations { result in
            switch result {
            case .success(let organizations):
                XCTAssertEqual(organizations.count, 2)
                XCTAssertEqual(organizations[0].login, "errfree")
                XCTAssertEqual(organizations[1].login, "engineyard")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetOrganizations() {
        // Test to validate the real conection
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
