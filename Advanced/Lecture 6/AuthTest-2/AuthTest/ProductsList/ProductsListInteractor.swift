//
//  ProductsListInteractor.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

final class ProductCollectionInteractor {
    weak var output: ProductCollectionInteractorOutput?
    private let productService: ProductsServiceDescription
    
    init(productService: ProductsServiceDescription) {
        self.productService = productService
    }
}

extension ProductCollectionInteractor: ProductCollectionInteractorInput {
    func obtainProducts() {
        productService.obtainProductsFromServer { [weak output] products in
            output?.didObtainProducts(with: products)
        }
    }
    
    func startObsrveViewedProducts() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didProductMarkAsViewed),
                                               name: ProductViewedManager.notificationkey,
                                               object: nil)
    }
}

private extension ProductCollectionInteractor {
    @objc
    func didProductMarkAsViewed() {
        output?.didProductMarkAsViewed()
    }
}
