//
//  ProductContainer.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//  
//

import UIKit

final class ProductContainer {
    let input: ProductModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProductRouterInput!
    
    class func assemble(with context: ProductContext) -> ProductContainer {
        let router = ProductRouter()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter(router: router,
                                         interactor: interactor,
                                         product: context.product)
        let viewController = ProductViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ProductContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProductModuleInput, router: ProductRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProductContext {
    let product: Product
    weak var moduleOutput: ProductModuleOutput?
}
