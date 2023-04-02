//
//  NetworkManager.swift
//  Posts
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import Foundation


protocol NetworkManagerDescription {
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

enum NetworkError: Error {
    case emptyData
    case unexpectedError
}

final class NetworkManager: NetworkManagerDescription {
    static let shared = NetworkManager()
    
    private init() {}
    
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
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
                let posts = try decoder.decode([Post].self, from: data)
                completion(.success(posts))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
