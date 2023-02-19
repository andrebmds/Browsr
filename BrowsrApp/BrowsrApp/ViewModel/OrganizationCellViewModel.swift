//
//  OrganizationCellViewModel.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/19/23.
//

import UIKit
import BrowsrLib

class OrganizationCellViewModel {
    let organization: Organization
    var avatarImage: UIImage?
    let avatarImageCache = NSCache<NSString, UIImage>()
    
    var name: String {
        return organization.login ?? ""
    }
    
    init(organization: Organization) {
        self.organization = organization
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let login = organization.login else { return }
        if let cachedImage = avatarImageCache.object(forKey: login as NSString) {
            avatarImage = cachedImage
            completion(avatarImage)
        } else if let avatarURL = organization.avatarURL, let url = URL(string: avatarURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.avatarImageCache.setObject(image, forKey: login as NSString)
                        self.avatarImage = image
                        completion(self.avatarImage)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
