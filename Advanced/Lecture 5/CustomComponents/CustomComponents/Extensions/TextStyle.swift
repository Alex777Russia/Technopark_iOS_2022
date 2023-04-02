//
//  TextStyle.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

enum TextStyle {
    case header1
    case title1
    case title2
    case body1
    case body2
}

extension TextStyle {
    var font: UIFont {
        switch self {
        case .header1:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .title1:
            return UIFont(name: "Noteworthy", size: fontSize)!
        case .title2:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .body1:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .body2:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        }
    }
    
    private var fontSize: CGFloat {
        switch self {
        case .header1:
            return 19
        case .title1, .title2:
            return 17
        case .body1, .body2:
            return 15
        }
    }
    
    private var fontWeight: UIFont.Weight {
        switch self {
        case .header1:
            return .bold
        case .title1, .title2:
            return .semibold
        case .body1, .body2:
            return .regular
        }
    }
}
