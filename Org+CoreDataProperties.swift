//
//  Org+CoreDataProperties.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/20/23.
//
//

import Foundation
import CoreData


extension Org {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Org> {
        return NSFetchRequest<Org>(entityName: "Organization")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool
    
}

extension Org : Identifiable {
    
}
