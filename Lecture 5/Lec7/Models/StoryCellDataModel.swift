//
//  StoryCellDataModel.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

struct StoryCellDataModel {
    func loadStroies() -> [StoryCellModel] {
        let stories: [StoryCellModel] = [.init(image: UIImage(named: "cat1"), isViewed: false),
                                         .init(image: UIImage(named: "cat2"), isViewed: false),
                                         .init(image: UIImage(named: "cat3"), isViewed: false),
                                         .init(image: UIImage(named: "cat4"), isViewed: false),
                                         .init(image: UIImage(named: "cat5"), isViewed: false),
                                         .init(image: UIImage(named: "cat6"), isViewed: false),
                                         .init(image: UIImage(named: "cat7"), isViewed: false),
                                         .init(image: UIImage(named: "cat8"), isViewed: false),
                                         .init(image: UIImage(named: "cat9"), isViewed: false),
                                         .init(image: UIImage(named: "cat10"), isViewed: true)]
        
        return stories
    }
}
