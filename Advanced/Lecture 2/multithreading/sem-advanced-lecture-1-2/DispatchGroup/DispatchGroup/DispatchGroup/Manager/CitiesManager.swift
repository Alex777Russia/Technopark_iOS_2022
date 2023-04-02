//
//  CitiesManager.swift
//  DispatchGroup
//
//  Created by k.kulakov on 14.02.2023.
//

import Foundation

enum NetworkError: Error {
    case unexpected
}

protocol CitiesManagerDescription: AnyObject {
    func loadCity(with name: String, completion: @escaping (Result<CityResponse, Error>) -> Void)
}

final class CitiesManager: CitiesManagerDescription {
    private static let appId = "a38a69833f4040853b4ef08063f5986d"
    //
    private let decoder = JSONDecoder()

    static let shared: CitiesManagerDescription = CitiesManager()
    
    private init() {}
    
    
    func loadCity(with name: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=metric&APIKEY=\(CitiesManager.appId)") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        let mainThreadCompletion: (Result<CityResponse, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                mainThreadCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                mainThreadCompletion(.failure(NetworkError.unexpected))
                return
            }
            
            do {
                let result = try self.decoder.decode(CityResponse.self, from: data)
                
                mainThreadCompletion(.success(result))
            } catch let error {
                mainThreadCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
}
