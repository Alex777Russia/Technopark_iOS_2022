//
//  ProfileInteractor.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

final class ProfileInteractor {
	weak var output: ProfileInteractorOutput?
    
    private let coreDataManager: DataBaseManagerDescription = DataBaseManager.shared
}

extension ProfileInteractor: ProfileInteractorInput {
    func saveProduct(with name: String) {
        coreDataManager.initIfNeeded(successBlock: { [weak self] in
            self?.coreDataManager.create(with: "ProductMO") { productMO in
                guard let productMO = productMO as? ProductMO else {
                    return
                }
                
                productMO.id = UUID().uuidString
                productMO.title = name
                productMO.price = Float(Int.random(in: 0...1000))
                productMO.isVerified = Bool.random()
                productMO.isFavourite = Bool.random()
                productMO.imageURL = "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
            }
        }, errorBlock: nil)
    }
}
