//
//  DataManager.swift
//  CoreDataApp
//
//  Created by e.korotkiy on 21.03.2023.
//

import Foundation
import CoreData

final class DataManager {
    private let modelName = "Person"
    private let container: NSPersistentContainer
    
    var mainQueueContex: NSManagedObjectContext {
        return container.viewContext
    }
    
    static let shared = DataManager()
    
    private init() {
        container = NSPersistentContainer(name: modelName)
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func initCoreData(completion: @escaping () -> Void) {
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("[DEBUG]: CoreData Init error: \(error.localizedDescription)")
            }
            
            debugPrint("[DEBUG]: CoreData Init description: \(description)")
            
            completion()
        }
    }
    
    func fetch<T>(with request: NSFetchRequest<T>) -> [T] {
        return (try? mainQueueContex.fetch(request)) ?? []
    }
    
    func create<T: NSManagedObject>(with entityName: String,
                                    configurationBlock: @escaping (T) -> Void) {
        container.performBackgroundTask { backgroundContext in
            guard
                let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                    into: backgroundContext) as? T
            else {
                return
            }
            
            configurationBlock(newObject)
            
            try? backgroundContext.save()
        }

    }
}
