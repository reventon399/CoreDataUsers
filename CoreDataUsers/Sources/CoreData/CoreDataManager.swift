//
//  CoreDataManager.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 07.01.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistantContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "CoreDataUsers")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    
    func fetchUsers() -> [Person] {
        var personsArray: [Person] = []
        var context = persistantContainer.viewContext
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            personsArray = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        
        return personsArray
    }
    
    func saveContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
}
