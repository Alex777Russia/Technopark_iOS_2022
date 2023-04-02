//
//  ProductsListInteractor.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation
import CoreData

final class ProductCollectionInteractor: NSObject {
    weak var output: ProductCollectionInteractorOutput?
    private let productService: ProductsServiceDescription
    private let coreDataManager: DataBaseManagerDescription = DataBaseManager.shared
    
    private lazy var frc: NSFetchedResultsController<ProductMO> = {
        let request = ProductMO.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(ProductMO.title),
                                              ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: coreDataManager.viewContex,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        
        return frc
    }()
    
    init(productService: ProductsServiceDescription) {
        self.productService = productService
        
        super.init()
        
        coreDataManager.initIfNeeded { [weak self] in
            self?.setupFrc()
        } errorBlock: { error in
            debugPrint("[DEBUG]: \(error.localizedDescription)")
        }
    }
    
    private func setupFrc() {
        frc.delegate = self
        
        try? frc.performFetch()
    }
}

extension ProductCollectionInteractor: ProductCollectionInteractorInput {
    func obtainProducts() {
        productService.obtainProducts { [weak output] products in
            output?.didObtainProducts(with: products)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let request = ProductMO.fetchRequest()
//            request.predicate = NSPredicate(format: "%K == %@", "id", "3")
//
//            DataBaseManager.shared.update(with: request) { productMO in
//                productMO.title = "TEST"
//                productMO.price = 9999999
//            }
//        }
    }
    
    func startObsrveViewedProducts() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didProductMarkAsViewed),
                                               name: ProductViewedManager.notificationkey,
                                               object: nil)
    }
}

private extension ProductCollectionInteractor {
    @objc
    func didProductMarkAsViewed() {
        output?.didProductMarkAsViewed()
    }
}

extension ProductCollectionInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        obtainProducts()
    }
}
