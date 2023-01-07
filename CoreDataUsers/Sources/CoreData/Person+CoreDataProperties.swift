//
//  Person+CoreDataProperties.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 07.01.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var image: Data?
    @NSManaged public var dateOfBirth: Date?

}

extension Person : Identifiable {

}
