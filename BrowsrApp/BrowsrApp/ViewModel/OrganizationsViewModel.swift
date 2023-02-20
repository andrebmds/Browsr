//
//  OrganizationsViewModel.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/19/23.
//

import UIKit
import BrowsrLib

class OrganizationsViewModel {
    var organizations: [Item] = []
    var filteredOrganizations: [Item] = []
    var fetchOrganizations: ((@escaping () -> Void) -> Void)?
    var api: GithubAPI
    private var searchTask: DispatchWorkItem?
    init(api: GithubAPI) {
        self.api = api
        fetchOrganizations = { [weak self] completion in
            guard let self = self else { return }
            self.getOrganizations(page: 1, perPage: 30) {
                completion()
            }
        }
    }
    func filterOrganizations(with searchText: String, completion: @escaping () -> Void) {
        // Cancel any previous search task that may be in progress
        searchTask?.cancel()
        // Create a new search task with a 0.5 second delay
        searchTask = DispatchWorkItem { [weak self] in
            self?.api.searchOrganizations(query: searchText) { [weak self] result in
                switch result {
                case .success(let organizations):
                    self?.filteredOrganizations = organizations.items ?? []
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion() 
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchTask!)
    }
    
    func getOrganizations(page: Int, perPage: Int, completion: @escaping () -> Void ){
        api.getOrganizations(page: page, perPage: perPage) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let organizations):
                self.organizations = organizations
                self.filteredOrganizations = self.organizations
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
}
