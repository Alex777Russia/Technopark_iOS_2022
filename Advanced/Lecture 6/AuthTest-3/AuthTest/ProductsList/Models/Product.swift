//
//  Product.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import Foundation

// MARK: Passive model

struct Product {
    let id: String
    let title: String
    let price: String
    let verified: Bool
    let favorite: Bool
    let imageUrl: String
    
    var isViewed: Bool {
        return ProductViewedManager.shared.isViewed(with: id)
    }
    
    init(id: String,
         title: String,
         price: String,
         verified: Bool,
         favorite: Bool,
         imageUrl: String) {
        self.id = id
        self.title = title
        self.price = price
        self.verified = verified
        self.favorite = favorite
        self.imageUrl = imageUrl
    }
    
    init(from product: ProductRaw) {
        id = "\(product.id)"
        title = product.productTitle
        price = "\(product.price)"
        verified = Bool.random()
        favorite = Bool.random()
        imageUrl = product.image
    }
    
    init(from productMO: ProductMO) {
        id = productMO.id ?? ""
        title = productMO.title ?? ""
        price = "\(productMO.price)"
        verified = Bool.random()
        favorite = Bool.random()
        imageUrl = productMO.imageURL ?? ""
    }
}
