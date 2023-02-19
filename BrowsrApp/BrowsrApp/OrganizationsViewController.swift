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
    //    var searchBar: UISearchBar!
    
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
        
//        register(ImageTableViewCell.self, forCellReuseIdentifier: imageCellIdentifier)

        view.addSubview(tableView)
        
        // Set up the search bar
        //        searchBar.delegate = self
        setConstraints()
        // Fetch the organizations
        fetchOrganizations()
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
                //                self.organizations = organizations.items
                self.filteredOrganizations = organizations
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
            
            // Set the placeholder image in the imageView.
            cell.avatarImageView.image = UIImage(named: "placeHolder")
            
            let organization = filteredOrganizations[indexPath.row]
            cell.nameLabel.text = organization.login
            if let avatarURL = organization.avatarURL, let url = URL(string: avatarURL) {
                // Download the image asynchronously and update the imageView on completion.
                cell.avatarImageView.loadImage(fromURL: url) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.avatarImageView.image = image
//                            tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    case .failure(let error):
                        print("Error downloading image: \(error)")
                    }
                }
            }
            
            return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath)
//        cell.imageView?.image = UIImage()
//        let organization = filteredOrganizations[indexPath.row]
//        cell.textLabel?.text = organization.login
//        if let avatarURL = organization.avatarURL, let url = URL(string: avatarURL) {
//            // Download the image asynchronously and update the imageView on completion.
//            cell.imageView?.loadImage(fromURL: url) { result in
//                switch result {
//                case .success(let image):
//                    cell.imageView?.image = image
//                    tableView.reloadRows(at: [indexPath], with: .none)
//                case .failure(let error):
//                    print("Error downloading image 🔴: \(error)")
//                }
//            }
//        }
//
//        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension OrganizationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = filteredOrganizations[indexPath.row]
        //        print("Selected organization: \(organization.login)")
    }
}

//extension OrganizationsViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredOrganizations = organizations
//        } else {
//            //            filteredOrganizations = organizations.filter { organization in
//            ////                return organization.login.lowercased().contains(searchText.lowercased())
//            //            }
//        }
//        tableView.reloadData()
//    }
//}
