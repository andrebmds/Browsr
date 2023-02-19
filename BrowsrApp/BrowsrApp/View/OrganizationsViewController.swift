//
//  ViewController.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/18/23.
//

import UIKit
import BrowsrLib

class OrganizationsViewController: UIViewController {
    
    var tableView: UITableView!
    var searchBar = UISearchBar()

    var organizations: [Organization] = []
    var filteredOrganizations: [Organization] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50//UITableView.automaticDimension

        tableView.register(OrganizationCell.self, forCellReuseIdentifier: "OrganizationCell")
        view.addSubview(tableView)
        
        // Set up the search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        setConstraints()
        // Fetch the organizations
        fetchOrganizations()
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func fetchOrganizations() {
        let api = GithubAPI()
        api.getOrganizations { result in
            switch result {
            case .success(let organizations):
                self.organizations = organizations
                self.filteredOrganizations = self.organizations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension OrganizationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOrganizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath) as! OrganizationCell
            let organization = filteredOrganizations[indexPath.row]
            cell.configure(with: organization)
            return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension OrganizationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = filteredOrganizations[indexPath.row]
        print("Selected organization: \(organization.login ?? "")")
    }
}

extension OrganizationsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredOrganizations = organizations
        } else {
            filteredOrganizations = organizations.filter { organization in
                guard let login = organization.login else { return false }
                return login.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
