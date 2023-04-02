//
//  CellModel.swift
//  WeatherApp
//
//  Created by Artur Sardaryan on 08.11.2022.
//

import Foundation

struct CellModel {
    let title: String
    let temp: String
    let time: String
    let iconURL: URL?
    
    init(with cityResponse: CityResponse) {
        self.title = cityResponse.name
        self.temp = "\(Int(round(cityResponse.main.temp)))˚C"
        
        let date = Date(timeIntervalSince1970: Double(cityResponse.dt))
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        self.time = dateFormatter.string(from: date)
        
        if let iconCode = cityResponse.weather.first?.icon {
            self.iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")
        } else {
            self.iconURL = nil
        }
    }
}
