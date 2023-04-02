//
//  ProductsService.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import Foundation

protocol ProductsServiceDescription {
    func obtainProducts(completion: @escaping ([Product]) -> Void)
}

final class ProductsService {
    private let coreDataManager: DataBaseManagerDescription = DataBaseManager.shared
}

extension ProductsService: ProductsServiceDescription {
    func obtainProducts(completion: @escaping ([Product]) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion([])
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        coreDataManager.initIfNeeded { [weak self] in
            self?.coreDataManager.deleteAll(request: ProductMO.fetchRequest())
            debugPrint("[DEBUG]: CoreData products count: \(self?.coreDataManager.count(with: ProductMO.fetchRequest()))")
        } errorBlock: { _ in}

        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            let decoder = JSONDecoder()
            
            guard
                let data = data,
                let rawProducts = try? decoder.decode([ProductRaw].self, from: data)
            else {
                return
            }
            
            self?.coreDataManager.initIfNeeded {
                
                rawProducts.forEach { rawProduct in
                    self?.coreDataManager.create(with: "ProductMO") { productMO in
                        guard let productMO = productMO as? ProductMO else {
                            return
                        }
                        
                        productMO.id = "\(rawProduct.id)"
                        
                        productMO.title = rawProduct.productTitle
                        productMO.price = rawProduct.price
                        productMO.isVerified = false
                        productMO.isFavourite = false
                        productMO.imageURL = rawProduct.image
                    }
                }
                
            } errorBlock: { error in
                debugPrint("[DEBUG]: CoreData error: \(error.localizedDescription)")
            }
            
            debugPrint("[DEBUG]: CoreData products count: \(self?.coreDataManager.count(with: ProductMO.fetchRequest()))")

            let products = rawProducts.map({ Product(from: $0) })
            
            DispatchQueue.main.async {
                completion(products)
            }
            
        }.resume()
    }
}
