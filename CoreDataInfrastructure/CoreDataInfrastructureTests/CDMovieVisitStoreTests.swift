//
//  CDMovieVisitStoreTests.swift
//  CoreDataInfrastructureTests
//
//  Created by Alonso on 11/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest

@testable import CoreDataInfrastructure
@testable import UpcomingMoviesDomain
import CoreData

protocol CDStoreTestsProtocol {
    associatedtype CDEntity: NSManagedObject & Managed

    var storeToTest: PersistenceStore<CDEntity>! { get }
    var mockPersistantContainer: NSPersistentContainer! { get }

    func flush() throws
}

extension CDStoreTestsProtocol {
    func flush() throws {
        guard let context = mockPersistantContainer?.viewContext else { return }
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: CDEntity.entityName)
        let objs = try context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            context.delete(obj)
        }
        try context.save()
    }
}

class CDMovieVisitStoreTests: XCTestCase, CDStoreTestsProtocol {

    var storeToTest: PersistenceStore<CDMovieVisit>!
    var mockPersistantContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()
        mockPersistantContainer = CoreDataStack.shared.mockPersistantContainer
        storeToTest = PersistenceStore(mockPersistantContainer)
    }

    override func tearDownWithError() throws {
        try flush()

        storeToTest = nil
        mockPersistantContainer = nil
        super.tearDown()
        try super.tearDownWithError()
    }

    func testSaveMovieVisitSuccess() {
        // Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie visit")
        // Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: "/poster") { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertTrue(existMovieVisit)
            saveExpectation.fulfill()
        }
        // Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

    func testSaveMovieVisitError() {
        // Arrange
        let saveExpectation = XCTestExpectation(description: "Should not save movie visit")
        // Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: nil) { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertFalse(existMovieVisit)
            saveExpectation.fulfill()
        }
        // Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}
