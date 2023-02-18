//
//  GithubAPI.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

protocol GithubAPIType {
    func getOrganizations(completion: @escaping (Result<Organizations, Error>) -> Void)
    func searchOrganizations(query: String, completion: @escaping (Result<Organizations, Error>) -> Void)
}

class GithubAPI {
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
}
extension GithubAPI: GithubAPIType {
    func searchOrganizations(query: String, completion: @escaping (Result<Organizations, Error>) -> Void) {
        let endpoint = GitHubEndpoint.searchOrganizations(query: query)
        apiService.request(endpoint) { (result: Result<Organizations, Error>) in
            completion(result)
        }
    }

    func getOrganizations(completion: @escaping (Result<Organizations, Error>) -> Void) {
        let endpoint = GitHubEndpoint.listOrganizations
        apiService.request(endpoint) { (result: Result<Organizations, Error>) in
            completion(result)
        }
    }
}
