//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation


// a38a69833f4040853b4ef08063f5986d

protocol NetworkManagerDescription {
    func loadWeather(for city: String, completion: @escaping (Result<CityResponse, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class NetworkManager: NetworkManagerDescription {
    private let appId = "a38a69833f4040853b4ef08063f5986d"
    
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func loadWeather(for city: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appId)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let cityResponse = try decoder.decode(CityResponse.self, from: data)
                completion(.success(cityResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
