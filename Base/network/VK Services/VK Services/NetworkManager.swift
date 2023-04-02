//
//  NetworkManager.swift
//  VK Services
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation

protocol NetworkManagerDescription {
    func loadServices(completion: @escaping (Result<[Service], Error>) -> Void)
}

enum NetworkError: Error {
    case unexpectedError
    case emptyData
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func loadServices(completion: @escaping (Result<[Service], Error>) -> Void) {
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else {
            completion(.failure(NetworkError.unexpectedError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(Response.self, from: data)
                completion(.success(response.body.services))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
