//
//  Model.swift
//  WeatherApp
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation

struct CityResponse: Codable {
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let icon: String
    }
    
    let main: Main
    let name: String
    let dt: Int
    let weather: [Weather]
}
