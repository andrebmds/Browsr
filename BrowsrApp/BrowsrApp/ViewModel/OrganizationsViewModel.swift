//
//  OrganizationsViewModel.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/19/23.
//

import UIKit
import BrowsrLib

class OrganizationsViewModel {
    var organizations: [Organization] = []
    var filteredOrganizations: [Organization] = []

    var fetchOrganizations: ((@escaping () -> Void) -> Void)?

    init(api: GithubAPI) {
        fetchOrganizations = { [weak self] completion in
            api.getOrganizations { result in
                switch result {
                case .success(let organizations):
                    self?.organizations = organizations
                    self?.filteredOrganizations = self?.organizations ?? []
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func filterOrganizations(with searchText: String) {
        if searchText.isEmpty {
            filteredOrganizations = organizations
        } else {
            filteredOrganizations = organizations.filter { organization in
                guard let login = organization.login else { return false }
                return login.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
