//
//  FavoriteOrganizationsManagerTests.swift
//  BrowsrAppTests
//
//  Created by Andre Bortoli on 2/20/23.
//

import XCTest
import CoreData
@testable import BrowsrApp

class FavoriteOrganizationsManagerTests: XCTestCase {
    
    var sut: FavoriteOrganizationsManager!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Set up a test Core Data stack
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        sut = FavoriteOrganizationsManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        context = nil
        
        try super.tearDownWithError()
    }
    
    func testRemoveFavoriteOrganization() throws {
        // Given
        let id = 123
        FavoriteOrganizationsManager.saveFavoriteOrganization(id: id)
        
        // When
        FavoriteOrganizationsManager.removeFavoriteOrganization(id: id)
        
        // Then
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Org")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", id)
        let result = try context.fetch(fetchRequest) as! [NSManagedObject]
        XCTAssert(result.count == 0)
    }
    
    func testIsFavorite() throws {
        // Given
        let id = 123
        FavoriteOrganizationsManager.saveFavoriteOrganization(id: id)
        
        // When
        let isFavorite = FavoriteOrganizationsManager.isFavorite(id: id)
        
        // Then
        XCTAssert(isFavorite)
    }
}
