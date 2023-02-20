//
//  Endpoint.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    func request() -> URLRequest {
        // Construct the URL for the endpoint
        let baseURL = "https://api.github.com"
        let urlString = baseURL + path
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        // Create the URL request with the appropriate method and headers
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Add the parameters to the request body or query string, depending on the HTTP method
        if let parameters = parameters {
            if method == .get {
                var urlComponents = URLComponents(string: urlString)!
                urlComponents.queryItems = parameters.map { key, value in
                    URLQueryItem(name: key, value: "\(value)")
                }
                request.url = urlComponents.url
            } else {
                let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
            }
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum GitHubEndpoint {
    case listOrganizations(page: Int, perPage: Int)
    case searchOrganizations(query: String)
}

extension GitHubEndpoint: Endpoint {
    var path: String {
        switch self {
        case .listOrganizations:
            return "/organizations"
        case .searchOrganizations:
            return "/search/users"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: [String: Any]? {
        switch self {
        case .listOrganizations(let page, let perPage):
            return ["page": page, "per_page": perPage]
        case .searchOrganizations(let query):
            return ["q": "\(query)+type:org"]
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
