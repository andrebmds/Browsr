//
//  APIServiceMock.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

protocol URLSessionProtocol {
    associatedtype DataTaskType
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskType
}

extension URLSession: URLSessionProtocol {}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var resumeWasCalled = false
    typealias CompletionHandler = URLSessionMock.CompletionHandler

    private let completion: CompletionHandler

    init(completion: @escaping CompletionHandler) {
        self.completion = completion
    }

    func resume() {
        // create some data
        resumeWasCalled = true
        completion(nil, nil, nil)
    }
}

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
    func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        return URLSessionDataTaskMock(completion: completionHandler)
    }
}
