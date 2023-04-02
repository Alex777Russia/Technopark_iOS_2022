//
//  DataBaseManager.swift
//  AuthTest
//
//  Created by e.korotkiy on 21.03.2023.
//

import Foundation
import CoreData

protocol DataBaseManagerDescription {
    func initIfNeeded(successBlock: (() -> ())?, errorBlock: ((Error) -> ())?)
    
    func fetch<T: NSManagedObject>(with request: NSFetchRequest<T>) -> [T]
    func count<T: NSManagedObject>(with request: NSFetchRequest<T>) -> Int
    
    func create<T: NSManagedObject>(with entityName: String,
                                    configurationBlock: @escaping (T) -> Void)
    
    func delete<T: NSManagedObject>(with request: NSFetchRequest<T>)
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>)
    
    func update<T: NSManagedObject>(with request: NSFetchRequest<T>,
                                    configurationBlock: @escaping (T) -> Void)
    
    var viewContex: NSManagedObjectContext { get }
}

final class DataBaseManager {
    private let container: NSPersistentContainer
    private var isReady: Bool = false
    private lazy var createBackgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    private lazy var deleteAllBackgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    var viewContex: NSManagedObjectContext {
        return container.viewContext
    }
    
    static let shared: DataBaseManagerDescription = DataBaseManager()
    
    private init() {
        container = NSPersistentContainer(name: "YoulaLight")
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension DataBaseManager: DataBaseManagerDescription {
    func initIfNeeded(successBlock: (() -> ())?, errorBlock: ((Error) -> ())?) {
        guard !isReady else {
            successBlock?()
            return
        }
        
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                errorBlock?(error)
                return
            }
            
            self?.isReady = true
            successBlock?()
        }
    }
    
    func fetch<T>(with request: NSFetchRequest<T>) -> [T] where T : NSManagedObject {
        return (try? viewContex.fetch(request)) ?? []
    }
    
    func count<T>(with request: NSFetchRequest<T>) -> Int where T : NSManagedObject {
        return (try? viewContex.count(for: request)) ?? .zero
    }
    
    func create<T>(with entityName: String, configurationBlock: @escaping (T) -> Void) where T : NSManagedObject {
        createBackgroundContext.performAndWait { [weak self] in
            guard
                let createBackgroundContext = self?.createBackgroundContext,
                let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                    into: createBackgroundContext) as? T
            else {
                return
            }
            
            configurationBlock(newObject)
            
            try? self?.createBackgroundContext.save()
        }
    }
    
    func delete<T>(with request: NSFetchRequest<T>) where T : NSManagedObject {
        container.performBackgroundTask { [weak self] backgroundContext in
            let objects = self?.fetch(with: request)
            
            objects?.forEach({ self?.viewContex.delete($0)})
            
            try? backgroundContext.save()
        }
    }
    
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>) {
        deleteAllBackgroundContext.performAndWait { [weak self] in
            let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            _ = try? self?.deleteAllBackgroundContext.execute(batchRequest)
            
            try? self?.deleteAllBackgroundContext.save()
        }
    }
    
    func update<T>(with request: NSFetchRequest<T>, configurationBlock: @escaping (T) -> Void) where T : NSManagedObject {
        let objects = fetch(with: request)
        
        guard let object = objects.first else {
            return
        }
        
        container.performBackgroundTask { backgroundContext in
            configurationBlock(object)
            
            try? backgroundContext.save()
        }
    }
}
