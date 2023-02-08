//
//  StoryCellModel.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

struct StoryCellModel {
    let image: UIImage?
    let isViewed: Bool
    
    init(image: UIImage? = nil, isViewed: Bool = false) {
        self.image = image
        self.isViewed = isViewed
    }
}
