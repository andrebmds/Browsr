//
//  OrganizationCellViewModel.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/19/23.
//

import UIKit
import BrowsrLib

class OrganizationCellViewModel {
    let item: Item
    var avatarImage: UIImage?
    let avatarImageCache = NSCache<NSString, UIImage>()
    var isFavorite: Bool = false
    
    var name: String {
        return item.login ?? ""
    }
    
    init(organization: Item) {
        self.item = organization
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let login = item.login else { return }
        if let cachedImage = avatarImageCache.object(forKey: login as NSString) {
            avatarImage = cachedImage
            completion(avatarImage)
        } else if let avatarURL = item.avatarURL, let url = URL(string: avatarURL) {
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
    func toggleFavorite() {
        isFavorite = !isFavorite

//        guard let organization = organization else { return }
//        FavoriteOrganizationsManager.shared.toggleFavorite(organization)
    }
}
