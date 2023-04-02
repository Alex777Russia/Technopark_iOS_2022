//
//  ProductViewedManager.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//

import Foundation

protocol ProductViewedManagerDescription {
    func markAsViewed(with id: String)
    func isViewed(with id: String) -> Bool
}

final class ProductViewedManager {
    private let viewedKey: String = "com.sardart.AuthTest.viewedStoredKey"
    
    static let notificationkey: NSNotification.Name = .init(rawValue: "com.sardart.AuthTest.viewedNotificationKey")
    
    static let shared: ProductViewedManagerDescription = ProductViewedManager()
    
    private init() {
        
    }
}

extension ProductViewedManager: ProductViewedManagerDescription {
    func markAsViewed(with id: String) {
        let key: String = ("\(viewedKey)\(id)")
        
        UserDefaults.standard.set(true, forKey: key)
        
        NotificationCenter.default.post(name: Self.notificationkey, object: nil)
    }
    
    func isViewed(with id: String) -> Bool {
        let key: String = "\(viewedKey)\(id)"
        
        return UserDefaults.standard.bool(forKey: key)
    }
}
