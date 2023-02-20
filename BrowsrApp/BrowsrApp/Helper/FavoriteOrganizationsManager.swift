////
////  FavoriteOrganizationsManager.swift
////  BrowsrApp
////
////  Created by Andre Bortoli on 2/20/23.
////
//
//import UIKit
//
//import CoreData
//import BrowsrLib
//
//class FavoriteOrganizationsManager {
//    static let shared = FavoriteOrganizationsManager()
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "FavoriteOrganizations")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Failed to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//
//    func addOrganization(_ organization: Organization) {
//        let favoriteOrg = FavoriteOrganization(context: context)
//        favoriteOrg.id = Int32(organization.id)
////        favoriteOrg.login = organization.login
////        favoriteOrg.url = organization.url
////        favoriteOrg.avatarURL = organization.avatarURL
//        //        favoriteOrg.descriptionText = organization.description
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed to add organization to favorites: \(error.localizedDescription)")
//        }
//    }
//    func isFavorite(organization: Organization) -> Bool {
//        let context = persistentContainer.viewContext
//        guard let login = organization.login else { return false }
//        let fetchRequest: NSFetchRequest<FavoriteOrganization> = FavoriteOrganization.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "login = %@", login)
//        do {
//            let existingFavorite = try context.fetch(fetchRequest).first
//            return existingFavorite != nil
//        } catch {
//            print("Failed to check favorite organization: \(error)")
//            return false
//        }
//    }
//    func removeOrganization(_ organization: Organization) {
//        let fetchRequest: NSFetchRequest<FavoriteOrganization> = FavoriteOrganization.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %d", organization.id)
//
//        do {
//            let favoriteOrgs = try context.fetch(fetchRequest)
//            for favoriteOrg in favoriteOrgs {
//                context.delete(favoriteOrg)
//            }
//            try context.save()
//        } catch {
//            print("Failed to remove organization from favorites: \(error.localizedDescription)")
//        }
//    }
//
//    func fetchFavoriteOrganizations() -> [Organization] {
//        let fetchRequest: NSFetchRequest<FavoriteOrganization> = FavoriteOrganization.fetchRequest()
//
//        do {
//            let favoriteOrgs = try context.fetch(fetchRequest)
//            let organizations = favoriteOrgs.map { organization -> Organization in
//                return Organization(
////                    login: organization.login ?? "",
//                    id: Int(organization.id)
////                    nodeID: "",
////                    url: organization.url ?? "",
////                    reposURL: "",
////                    eventsURL: "",
////                    hooksURL: "",
////                    issuesURL: "",
////                    membersURL: "",
////                    publicMembersURL: "",
////                    avatarURL: organization.avatarURL ?? ""
//                    //                    description: organization.descriptionText ?? ""
//                    )
//            }
//            return organizations
//        } catch {
//            print("Failed to fetch favorite organizations: \(error.localizedDescription)")
//            return []
//        }
//    }
//}
