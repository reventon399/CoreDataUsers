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
        let context = persistantContainer.viewContext
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
    
    // TODO: change to addNewPerson
    func savePerson(personName: String) {
        let context = persistantContainer.viewContext
        let personObject = Person(context: context)
        personObject.name = personName
        saveContext()
    }
    
    func deletePerson(person: Person) {
        persistantContainer.viewContext.delete(person)
        saveContext()
    }
    
    func updatePerson(name: String, dateOfBirth: Date?, gender: String, image: Data?) {
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        if let persons = try? persistantContainer.viewContext.fetch(fetchRequest), !persons.isEmpty {
            guard let updatingPerson = persons.first else { return }
            updatingPerson.setValue(name, forKey: "name")
            updatingPerson.setValue(dateOfBirth, forKey: "dateOfBirth")
            updatingPerson.setValue(gender, forKey: "gender")
            updatingPerson.setValue(image, forKey: "image")
            try? persistantContainer.viewContext.save()
        }
    }
}
