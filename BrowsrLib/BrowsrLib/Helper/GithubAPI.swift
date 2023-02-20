//
//  GithubAPI.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

protocol GithubAPIType {
    func getOrganizations(completion: @escaping (Result<[Organization], Error>) -> Void)
    func searchOrganizations(query: String, completion: @escaping (Result<[Organization], Error>) -> Void)
    func getFavoriteOrganizations(completion: @escaping (Result<[Organization], Error>) -> Void)
    func setFavorite(_ isFavorite: Bool, forOrganization organization: Organization, completion: @escaping (Result<Void, Error>) -> Void)
    
}

public class GithubAPI {
    private let apiService: APIService
    
    public init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
}

extension GithubAPI: GithubAPIType {
    public func searchOrganizations(query: String, completion: @escaping (Result<[Organization], Error>) -> Void) {
        let endpoint = GitHubEndpoint.searchOrganizations(query: query)
        apiService.request(endpoint) { (result: Result<[Organization], Error>) in
            completion(result)
        }
    }
    
    public func getOrganizations(completion: @escaping (Result<[Organization], Error>) -> Void) {
        let endpoint = GitHubEndpoint.listOrganizations
        apiService.request(endpoint) { (result: Result<[Organization], Error>) in
            completion(result)
        }
    }
    public func getFavoriteOrganizations(completion: @escaping (Result<[Organization], Error>) -> Void) {
        // TODO: Implement the storage method for getting favorite organizations
    }
    
    public func setFavorite(_ isFavorite: Bool, forOrganization organization: Organization, completion: @escaping (Result<Void, Error>) -> Void) {
        // TODO: Implement the storage method for setting the favorite status of an organization
    }
}
