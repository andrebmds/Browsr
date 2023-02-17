//
//  APIService.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import UIKit

enum APIError: Error {
    case invalidResponse
    case invalidData
}

class APIService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        // Create a URL request based on the endpoint
        let request = endpoint.request()
        //Bortoli
        // Create a data task to make the request
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in

            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
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
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the data task
        task.resume()
    }
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var nextResponse: HTTPURLResponse?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return nextDataTask as URLSessionDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeWasCalled = false

    override func resume() {
        resumeWasCalled = true
    }
}

