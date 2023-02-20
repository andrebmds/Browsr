//
//  GithubAPI.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

protocol GithubAPIType {
    func getOrganizations(completion: @escaping (Result<[Item], Error>) -> Void)
    func searchOrganizations(query: String, completion: @escaping (Result<Organizations, Error>) -> Void)
}

public class GithubAPI {
    private let apiService: APIService
    
    public init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
}

extension GithubAPI: GithubAPIType {
    public func searchOrganizations(query: String, completion: @escaping (Result<Organizations, Error>) -> Void) {
        let endpoint = GitHubEndpoint.searchOrganizations(query: query)
        apiService.request(endpoint) { (result: Result<Organizations, Error>) in
            completion(result)
        }
    }
    
    public func getOrganizations(completion: @escaping (Result<[Item], Error>) -> Void) {
        let endpoint = GitHubEndpoint.listOrganizations
        apiService.request(endpoint) { (result: Result<[Item], Error>) in
            completion(result)
        }
    }
}
