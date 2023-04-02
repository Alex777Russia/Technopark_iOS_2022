//
//  Person+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by e.korotkiy on 21.03.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?

}

extension Person : Identifiable {

}
