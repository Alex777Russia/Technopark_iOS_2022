//
//  ProductMO+CoreDataProperties.swift
//  AuthTest
//
//  Created by e.korotkiy on 21.03.2023.
//
//

import Foundation
import CoreData


extension ProductMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductMO> {
        return NSFetchRequest<ProductMO>(entityName: "ProductMO")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var price: Float
    @NSManaged public var imageURL: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var isVerified: Bool

}

extension ProductMO : Identifiable {

}
