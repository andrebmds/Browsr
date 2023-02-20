//
//  ViewController.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/18/23.
//

import UIKit
import BrowsrLib
import Reachability

class OrganizationsViewController: UIViewController {
    
    var tableView: UITableView!
    var searchBar = UISearchBar()
    var viewModel: OrganizationsViewModel!
    var internetConnectionStatusImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        internetConnectionStatusImageView = UIImageView(image: UIImage(systemName: "wifi.slash"))

        internetConnectionStatusImageView?.isHidden = true
        view.addSubview(internetConnectionStatusImageView!)
        
        // Set up the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        tableView.register(OrganizationCell.self, forCellReuseIdentifier: "OrganizationCell")
        view.addSubview(tableView)
        
        // Set up the search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        setConstraints()
        // Fetch the organizations
        let api = GithubAPI()
        viewModel = OrganizationsViewModel(api: api)
        viewModel.fetchOrganizations? { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateInternetConnectionStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusDidChange), name: .reachabilityChanged, object: nil)
        do {
            let reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        let reachability = try! Reachability()
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc func networkStatusDidChange(_ notification: Notification) {
        updateInternetConnectionStatus()
    }
    
    func updateInternetConnectionStatus() {
        if NetworkManager.isConnectedToInternet() {
            internetConnectionStatusImageView?.isHidden = true
            tableView.isHidden = false
        } else {
            internetConnectionStatusImageView?.isHidden = false
            tableView.isHidden = true
        }
    }
    
    func setConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        internetConnectionStatusImageView?.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        if let internetConnectionStatusLabel = internetConnectionStatusImageView {
            internetConnectionStatusLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                internetConnectionStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                internetConnectionStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                internetConnectionStatusLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                internetConnectionStatusLabel.widthAnchor.constraint(equalTo: internetConnectionStatusLabel.heightAnchor)
            ])
        }
    }
}

extension OrganizationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredOrganizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath) as! OrganizationCell
        let organization = viewModel.filteredOrganizations[indexPath.row]
        let cellViewModel = OrganizationCellViewModel(organization: organization)
        cell.configure(with: cellViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension OrganizationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = viewModel.filteredOrganizations[indexPath.row]
        print("Selected organization: \(organization.login ?? "")")
    }
}

extension OrganizationsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterOrganizations(with: searchText) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterOrganizations(with: "") { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
