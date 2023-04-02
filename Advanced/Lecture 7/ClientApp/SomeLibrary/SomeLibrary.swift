//
//  SomeLibrary.swift
//  SomeLibrary
//
//  Created by o.gibadulin on 28.03.2023.
//

import UIKit

open class CustomColor {
    public static let backgroundColor: UIColor = .systemIndigo
}

open class Pencil {
    open var name: String = "Pencil"
    
    public init() {}
    
    open func write() {
        print("Writing by \(name)")
    }
}

//class Pen: Pencil {
//    
//}
