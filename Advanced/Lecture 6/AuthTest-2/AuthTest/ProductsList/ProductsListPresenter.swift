//
//  ProductsListPresenter.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

final class ProductCollectionPresenter {
    weak var view: ProductCollectionViewInput?
    weak var moduleOutput: ProductCollectionModuleOutput?
    
    private let router: ProductCollectionRouterInput
    private let interactor: ProductCollectionInteractorInput
    
    private var products: [Product] = []
    
    init(router: ProductCollectionRouterInput, interactor: ProductCollectionInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProductCollectionPresenter: ProductCollectionModuleInput {
}

extension ProductCollectionPresenter: ProductCollectionViewOutput {
    var count: Int {
        return products.count
    }
    
    func item(at index: Int) -> Product {
        return products[index]
    }
    
    func didLoadView() {
        interactor.obtainProducts()
        interactor.startObsrveViewedProducts()
    }
    
    func reloadData() {
        interactor.obtainProducts()
    }
    
    func didSelectItem(at index: Int) {
        let product = products[index]
        router.show(product: product)
    }
}

extension ProductCollectionPresenter: ProductCollectionInteractorOutput {
    func didObtainProducts(with products: [Product]) {
        self.products = products
        view?.reloadData()
    }
    
    func didProductMarkAsViewed() {
        interactor.obtainProducts()
    }
}
