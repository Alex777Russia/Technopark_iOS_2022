//
//  ProductProtocols.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//  
//

import Foundation

protocol ProductModuleInput {
    var moduleOutput: ProductModuleOutput? { get }
}

protocol ProductModuleOutput: AnyObject {
}

protocol ProductViewInput: AnyObject {
    func configure(with model: ProductViewModel)
}

protocol ProductViewOutput: AnyObject {
    func didLoadView()
}

protocol ProductInteractorInput: AnyObject {
    func markAsViewed(with product: Product)
}

protocol ProductInteractorOutput: AnyObject {
}

protocol ProductRouterInput: AnyObject {
}
