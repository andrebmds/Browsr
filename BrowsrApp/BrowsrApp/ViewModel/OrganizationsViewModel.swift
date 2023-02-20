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
            api.searchOrganizations(query: "") { result in
                switch result {
                case .success(let organizations):
                    self?.organizations = organizations.items ?? []
                    self?.filteredOrganizations = self?.organizations ?? []
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
    
}
