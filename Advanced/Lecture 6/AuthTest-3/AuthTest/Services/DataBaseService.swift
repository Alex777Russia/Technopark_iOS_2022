//
//  DataBaseService.swift
//  AuthTest
//
//  Created by e.korotkiy on 21.03.2023.
//

import Foundation

final class DataBaseService {
    private let coreDataManager: DataBaseManagerDescription = DataBaseManager.shared
}

extension DataBaseService: ProductsServiceDescription {
    func obtainProducts(completion: @escaping ([Product]) -> Void) {
        coreDataManager.initIfNeeded { [weak self] in
            guard let self = self else {
                return
            }
            
            let request = ProductMO.fetchRequest()
            let productsMO = self.coreDataManager.fetch(with: request)
            
            let products = productsMO.map({ Product(from: $0) })
            
            completion(products)
            
        } errorBlock: { error in
            debugPrint("[DEBUG]: CoreData error: \(error.localizedDescription)")
        }

    }
}
