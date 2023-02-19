//
//  APIService.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidData
}

public class APIService {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        // Create a URL request based on the endpoint
        let request = endpoint.request()
        // Create a data task to make the request
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            print("⬇︎ Response from::\(String(describing: request.url))")
            // Check for errors
            if let error = error {
                print("From rest 🔴:")
                print("Error \(error)")
                completion(.failure(error))
                return
            }
            // Check the response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                print("From rest 🔴:")
                print("statusCode \(statusCode)")
                completion(.failure(APIError.invalidResponse))
                return
            }
            // Parse the response data
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                print("From rest 🍏:")
                print(result)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        // Start the data task
        task.resume()
    }
}
