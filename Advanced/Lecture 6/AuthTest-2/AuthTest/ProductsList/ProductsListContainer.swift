//
//  ProductsListContainer.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class ProductCollectionContainer {
    let input: ProductCollectionModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProductCollectionRouterInput!
    
    class func assemble(with context: ProductCollectionContext) -> ProductCollectionContainer {
        let router = ProductCollectionRouter()
        let interactor = ProductCollectionInteractor(productService: ProductsService())
        let presenter = ProductCollectionPresenter(router: router, interactor: interactor)
        let viewController = ProductCollectionViewController(output: presenter)
        
        router.viewController = viewController
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ProductCollectionContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProductCollectionModuleInput, router: ProductCollectionRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProductCollectionContext {
    weak var moduleOutput: ProductCollectionModuleOutput?
}
