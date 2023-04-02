//
//  UIColor.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

extension UIColor {
    static let background: UIColor = Color(lightValue: UIColor(white: 1, alpha: 1),
                                           darkValue: UIColor(white: 0.1, alpha: 1)).value
    
    static let accent: UIColor = Color(lightValue: UIColor(red: 63, green: 182, blue: 255),
                                       darkValue: UIColor(red: 63, green: 182, blue: 255)).value
    
    static let highlightedAccent: UIColor = Color(lightValue: UIColor(red: 111, green: 201, blue: 255),
                                                  darkValue: UIColor(red: 111, green: 201, blue: 255)).value
    
    struct UI {
        public static var success = Color(lightValue: UIColor(red: 119, green: 194, blue: 38),
                                          darkValue: UIColor(red: 119, green: 194, blue: 38))
        
        public static var card = Color(lightValue: UIColor(white: 245.0 / 255.0, alpha: 1.0),
                                       darkValue: UIColor(red: 27, green: 31, blue: 41))
        
        public static var error = Color(lightValue: UIColor(red: 247, green: 80, blue: 89),
                                        darkValue: UIColor(red: 247, green: 80, blue: 89))
        
        public static var lightError = Color(lightValue: UIColor(red: 255, green: 126, blue: 126),
                                             darkValue: UIColor(red: 255, green: 126, blue: 126))
        
        public static var secondary = Color(lightValue: UIColor(red: 195, green: 195, blue: 195),
                                            darkValue: UIColor(red: 93, green: 92, blue: 94))
        
        public static var background = Color(lightValue: UIColor(red: 242, green: 242, blue: 247),
                                             darkValue: UIColor(red: 0, green: 0, blue: 0))
        
        public static var backgroundGray = Color(lightValue: UIColor(red: 235, green: 236, blue: 240),
                                                 darkValue: UIColor(red: 10, green: 10, blue: 10))
        
        public static var backgroundCard = Color(lightValue: UIColor(red: 227, green: 244, blue: 255),
                                                 darkValue: UIColor(red: 227, green: 244, blue: 255))
        
        public static var backgroundCard2 = Color(lightValue: UIColor(red: 208, green: 227, blue: 240),
                                                  darkValue: UIColor(red: 208, green: 227, blue: 240))
        
        public static var primary = Color(lightValue: UIColor(white: 51.0 / 255.0, alpha: 1.0),
                                          darkValue: UIColor(red: 243, green: 244, blue: 246))
        
        public static var separator = Color(lightValue: UIColor(white: 235.0 / 255.0, alpha: 1.0),
                                            darkValue: UIColor(white: 0.2, alpha: 1))
        
    }
    
    struct Text {
        public static var primary = Color(lightValue: UIColor(white: 51.0 / 255.0, alpha: 1.0),
                                          darkValue: UIColor(red: 243, green: 244, blue: 246))
        
        public static var secondary = Color(lightValue: UIColor(white: 112.0 / 255.0, alpha: 1.0),
                                            darkValue: UIColor(red: 163, green: 169, blue: 189))
        
        public static var link = Color(lightValue: UIColor(red: 112, green: 146, blue: 254),
                                       darkValue: UIColor(red: 112, green: 146, blue: 254))
    }
}
