//
//  ProductsListRouter.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class ProductCollectionRouter {
    weak var viewController: UIViewController?
}

extension ProductCollectionRouter: ProductCollectionRouterInput {
    func show(product: Product) {
        let context = ProductContext(product: product)
        let productViewController = ProductContainer.assemble(with: context).viewController
        
        viewController?.present(productViewController, animated: true)
    }
}
