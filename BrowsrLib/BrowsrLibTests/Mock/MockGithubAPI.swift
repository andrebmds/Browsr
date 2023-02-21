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
    var organizations: Organizations?
    
    public func searchOrganizations(query: String, completion: @escaping (Result<Organizations, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        }
        let data = responseData.rawValue.data(using: .utf8)!
        do {
            let decoder = JSONDecoder()
            let organizations = try decoder.decode(Organizations.self, from: data)
            completion(.success(organizations))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    private var responseData: ResponseData
    
    init(responseData: ResponseData) {
        self.responseData = responseData
    }
    
    public func getOrganizations(page: Int, perPage: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        let data = responseData.rawValue.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let organizations = try decoder.decode(Organizations.self, from: data)
            
            completion(.success(organizations.items ?? []))
        } catch {
            completion(.failure(error))
        }
    }
}

enum ResponseData: String {
    case validData = """
            {
                "total_count": 5027369,
                "incomplete_results": false,
                "items": [
                    {
                        "login": "microsoft",
                        "id": 6154722,
                        "node_id": "MDEyOk9yZ2FuaXphdGlvbjYxNTQ3MjI=",
                        "avatar_url": "https://avatars.githubusercontent.com/u/6154722?v=4",
                        "gravatar_id": "",
                        "url": "https://api.github.com/users/microsoft",
                        "html_url": "https://github.com/microsoft",
                        "followers_url": "https://api.github.com/users/microsoft/followers",
                        "following_url": "https://api.github.com/users/microsoft/following{/other_user}",
                        "gists_url": "https://api.github.com/users/microsoft/gists{/gist_id}",
                        "starred_url": "https://api.github.com/users/microsoft/starred{/owner}{/repo}",
                        "subscriptions_url": "https://api.github.com/users/microsoft/subscriptions",
                        "organizations_url": "https://api.github.com/users/microsoft/orgs",
                        "repos_url": "https://api.github.com/users/microsoft/repos",
                        "events_url": "https://api.github.com/users/microsoft/events{/privacy}",
                        "received_events_url": "https://api.github.com/users/microsoft/received_events",
                        "type": "Organization",
                        "site_admin": false,
                        "score": 1.0
                    },
                    {
                        "login": "openai",
                        "id": 14957082,
                        "node_id": "MDEyOk9yZ2FuaXphdGlvbjE0OTU3MDgy",
                        "avatar_url": "https://avatars.githubusercontent.com/u/14957082?v=4",
                        "gravatar_id": "",
                        "url": "https://api.github.com/users/openai",
                        "html_url": "https://github.com/openai",
                        "followers_url": "https://api.github.com/users/openai/followers",
                        "following_url": "https://api.github.com/users/openai/following{/other_user}",
                        "gists_url": "https://api.github.com/users/openai/gists{/gist_id}",
                        "starred_url": "https://api.github.com/users/openai/starred{/owner}{/repo}",
                        "subscriptions_url": "https://api.github.com/users/openai/subscriptions",
                        "organizations_url": "https://api.github.com/users/openai/orgs",
                        "repos_url": "https://api.github.com/users/openai/repos",
                        "events_url": "https://api.github.com/users/openai/events{/privacy}",
                        "received_events_url": "https://api.github.com/users/openai/received_events",
                        "type": "Organization",
                        "site_admin": false,
                        "score": 1.0
                    }
                ]
            }
            """
    case invalidData = "invalid data"
}
