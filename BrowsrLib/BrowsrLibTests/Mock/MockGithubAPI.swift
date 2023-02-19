//
//  MockGithubAPI.swift
//  BrowsrLibTests
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation
@testable import BrowsrLib

public class MockGithubAPI: GithubAPIType {
    var error: Error?
    var organizations: [Organization]?
    
    public func searchOrganizations(query: String, completion: @escaping (Result<[Organization], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let organizations = organizations {
            let response = [Organization](organizations)
            completion(.success(response))
        } else {
            completion(.failure(APIError.invalidData))
        }
    }
    
    private var responseData: ResponseData
    
    init(responseData: ResponseData) {
        self.responseData = responseData
    }
    
    public func getOrganizations(completion: @escaping (Result<[Organization], Error>) -> Void) {
        let data = responseData.rawValue.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let organizations = try decoder.decode([Organization].self, from: data)
            completion(.success(organizations))
        } catch {
            completion(.failure(error))
        }
    }
}

enum ResponseData: String {
    case validData = """
            [
                {
                    "login": "errfree",
                    "id": 44,
                    "node_id": "MDEyOk9yZ2FuaXphdGlvbjQ0",
                    "url": "https://api.github.com/orgs/errfree",
                    "repos_url": "https://api.github.com/orgs/errfree/repos",
                    "events_url": "https://api.github.com/orgs/errfree/events",
                    "hooks_url": "https://api.github.com/orgs/errfree/hooks",
                    "issues_url": "https://api.github.com/orgs/errfree/issues",
                    "members_url": "https://api.github.com/orgs/errfree/members{/member}",
                    "public_members_url": "https://api.github.com/orgs/errfree/public_members{/member}",
                    "avatar_url": "https://avatars.githubusercontent.com/u/44?v=4",
                    "description": null
                },
                {
                    "login": "engineyard",
                    "id": 81,
                    "node_id": "MDEyOk9yZ2FuaXphdGlvbjgx",
                    "url": "https://api.github.com/orgs/engineyard",
                    "repos_url": "https://api.github.com/orgs/engineyard/repos",
                    "events_url": "https://api.github.com/orgs/engineyard/events",
                    "hooks_url": "https://api.github.com/orgs/engineyard/hooks",
                    "issues_url": "https://api.github.com/orgs/engineyard/issues",
                    "members_url": "https://api.github.com/orgs/engineyard/members{/member}",
                    "public_members_url": "https://api.github.com/orgs/engineyard/public_members{/member}",
                    "avatar_url": "https://avatars.githubusercontent.com/u/81?v=4",
                    "description": ""
                }
            ]
            """
    case invalidData = "invalid data"
}
