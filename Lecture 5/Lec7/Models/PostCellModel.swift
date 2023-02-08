//
//  PostCellModel.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

final class PostCellModel {
    let author: String
    let description: String
    let image: UIImage?
    let isLiked: Bool
    
    init(author: String = "", description: String = "", image: UIImage? = nil, isLiked: Bool = false) {
        self.author = author
        self.description = description
        self.image = image
        self.isLiked = isLiked
    }
}
