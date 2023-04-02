//
//  Service.swift
//  VKTest
//
//

import Foundation

struct Request: Codable {
    let body: Body
    
    struct Body: Codable {
        let services: [Service]
    }
}

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}
