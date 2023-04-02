//
//  TableCellRegistrationExtension.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifire: String {
        return NSStringFromClass(self)
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifire)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("Can't dequeueReusableCell for \(T.reuseIdentifire)")
        }
        
        return cell
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifire: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifire)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("Can't dequeueReusableCell for \(T.reuseIdentifire)")
        }
        
        return cell
    }
}
