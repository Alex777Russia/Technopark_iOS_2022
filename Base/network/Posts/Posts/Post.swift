//
//  Post.swift
//  Posts
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation

struct Post: Codable {
    let identifier: Int
    let userIdentifier: Int
    let title: String
    let caption: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case userIdentifier = "userId"
        case title
        case caption = "body"
    }
}
