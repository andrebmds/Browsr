//
//  NetworkManager.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/20/23.
//

import Reachability

class NetworkManager {
    static func isConnectedToInternet() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .unavailable, .none:
            return false
        case .wifi, .cellular:
            return true
        }
    }
}
