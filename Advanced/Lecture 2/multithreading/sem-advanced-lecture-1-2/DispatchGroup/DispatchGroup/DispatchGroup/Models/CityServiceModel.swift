//
//  CityServiceModel.swift
//  DispatchGroup
//
//  Created by k.kulakov on 14.02.2023.
//

import Foundation

struct CityResponse: Decodable {
    let name: String
    let id: Int
    let main: CityMainInfo
    let sys: CitySysInfo
}

struct CityMainInfo: Decodable {
    let temp: Float
    let feelsLike: Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
    }
}

struct CitySysInfo: Decodable {
    let timezone: Int?
}

