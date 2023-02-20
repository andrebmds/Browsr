//
//  Organization+CoreDataProperties.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/20/23.
//
//

import Foundation
import CoreData


extension Organization {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Organization> {
        return NSFetchRequest<Organization>(entityName: "Organization")
    }

    @NSManaged public var login: String?
    @NSManaged public var id: Int64
    @NSManaged public var nodeID: String?
    @NSManaged public var url: String?
    @NSManaged public var reposURL: String?
    @NSManaged public var eventsURL: String?
    @NSManaged public var hooksURL: String?
    @NSManaged public var issuesURL: String?
    @NSManaged public var membersURL: String?
    @NSManaged public var publicMembersURL: String?
    @NSManaged public var avatarURL: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var orgDescription: String?

}

extension Organization : Identifiable {

}
