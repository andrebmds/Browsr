//
//  FavoriteOrganizationsManager.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/20/23.
//

import UIKit
import CoreData
import BrowsrLib

class FavoriteOrganizationsManager {
    static func saveFavoriteOrganization(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Org", in: context)
        let newOrganization = NSManagedObject(entity: entity!, insertInto: context)
        
        newOrganization.setValue(id, forKey: "id")
        newOrganization.setValue(true, forKey: "isFavorite")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func removeFavoriteOrganization(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Org")
        fetchRequest.predicate = NSPredicate(format: "id = %lld", id)
        
        do {
            let organizations = try context.fetch(fetchRequest)
            for organization in organizations {
                context.delete(organization as! NSManagedObject)
            }
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    static func isFavorite(id: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Org")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.count > 0
        } catch {
            print("Error fetching data: \(error)")
            return false
        }
    }
}
