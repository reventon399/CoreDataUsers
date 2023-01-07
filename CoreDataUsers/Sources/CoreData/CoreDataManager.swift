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
}
