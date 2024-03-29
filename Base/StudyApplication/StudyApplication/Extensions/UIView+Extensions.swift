//
//  UIView+Extensions.swift
//  StudyApplication
//
//  Created by e.korotkiy on 01.11.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
