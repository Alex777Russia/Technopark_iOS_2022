//
//  ProductsListProtocols.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

protocol ProductCollectionModuleInput {
    var moduleOutput: ProductCollectionModuleOutput? { get }
}

protocol ProductCollectionModuleOutput: AnyObject {
    func productCollectionModuleWillClose()
}

protocol ProductCollectionViewInput: AnyObject {
    func reloadData()
}

protocol ProductCollectionViewOutput: AnyObject {
    var count: Int { get }
    
    func item(at index: Int) -> Product
    func didLoadView()
    func reloadData()
    func didSelectItem(at index: Int)
}

protocol ProductCollectionInteractorInput: AnyObject {
    func obtainProducts()
    func startObsrveViewedProducts()
}

protocol ProductCollectionInteractorOutput: AnyObject {
    func didObtainProducts(with products: [Product])
    func didProductMarkAsViewed()
}

protocol ProductCollectionRouterInput: AnyObject {
    func show(product: Product)
}
