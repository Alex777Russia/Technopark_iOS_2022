//
//  Service.swift
//  VK Services
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}

struct Response: Decodable {
    struct Body: Decodable {
        let services: [Service]
    }
    
    let body: Body
}
