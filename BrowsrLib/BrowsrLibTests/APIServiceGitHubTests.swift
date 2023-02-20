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
        
        sut.getOrganizations(page: 1, perPage: 30) { result in
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
        
        mock.getOrganizations(page: 1, perPage: 30) { result in
            switch result {
            case .success(let organizations):
                XCTAssertEqual(organizations.count, 2)
                XCTAssertEqual(organizations[0].login, "microsoft")
                XCTAssertEqual(organizations[1].login, "openai")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
