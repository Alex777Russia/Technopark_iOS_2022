//
//  ProductRaw.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import Foundation

struct ProductRaw: Codable {
    let id: Int
    let price: Float
    let productTitle: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case productTitle = "title"
        case id, price, image
    }
}
