//
//  ProductInteractor.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//  
//

import Foundation

final class ProductInteractor {
    private let productViewedManager: ProductViewedManagerDescription
    weak var output: ProductInteractorOutput?
    
    init(productViewedManager: ProductViewedManagerDescription = ProductViewedManager.shared) {
        self.productViewedManager = productViewedManager
    }
}

extension ProductInteractor: ProductInteractorInput {
    func markAsViewed(with product: Product) {
        productViewedManager.markAsViewed(with: product.id)
    }
    
}
