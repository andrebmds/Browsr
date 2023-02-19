//
//  UIImageView+Extensions.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/19/23.
//

import UIKit

public extension UIImageView {
    func loadImage(fromURL url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        print("⬇︎ Response from image: GET::\(url)")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                print("From rest 🔴:")
                print("Error \(error ?? APIError.invalidResponse)")
                completion(.failure(error ?? APIError.invalidResponse))
                return
            }
            DispatchQueue.main.async {
                print("From rest 🍏:")
                self?.image = image
                completion(.success(image))
            }
        }
        task.resume()
    }
}
