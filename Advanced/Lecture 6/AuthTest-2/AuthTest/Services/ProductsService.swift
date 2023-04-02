//
//  ProductsService.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import Foundation

protocol ProductsServiceDescription {
    func obtainProductsFromServer(completion: @escaping ([Product]) -> Void)
}

final class ProductsService: ProductsServiceDescription {
    
    func obtainProductsFromServer(completion: @escaping ([Product]) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion([])
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            var products: [Product] = []
            
            defer {
                DispatchQueue.main.async {
                    completion(products)
                }
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let rawProducts = try? decoder.decode([ProductRaw].self, from: data) else {
                return
            }
            
            products = rawProducts.map({ Product(from: $0) })
        }.resume()
    }
}
