//
//  ProductPresenter.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//  
//

import Foundation

final class ProductPresenter {
    weak var view: ProductViewInput?
    weak var moduleOutput: ProductModuleOutput?
    
    private let router: ProductRouterInput
    private let interactor: ProductInteractorInput
    private let product: Product
    
    init(router: ProductRouterInput,
         interactor: ProductInteractorInput,
         product: Product) {
        self.router = router
        self.interactor = interactor
        self.product = product
    }
}

extension ProductPresenter: ProductModuleInput {
}

extension ProductPresenter: ProductViewOutput {
    func didLoadView() {
        guard let imageURL = URL(string: product.imageUrl) else {
            return
        }
        
        let viewModel = ProductViewModel(imageURL: imageURL, title: product.title)
        view?.configure(with: viewModel)
        interactor.markAsViewed(with: product)
    }
    
}

extension ProductPresenter: ProductInteractorOutput {
}
