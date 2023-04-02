//
//  ImageManager.swift
//  VKTest
//
//  Created by k.kulakov on 14.02.2023.
//

import Foundation

enum ImageManagerError: Error {
    case unexpected
}

protocol ImageManagerDescription {
    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ImageManager {
    private let networkQueue = DispatchQueue(label: "ru.techpark.ImageManager.networkQueue", attributes: .concurrent)
    
    static let shared: ImageManagerDescription = ImageManager()
    
    private init() {}
}

extension ImageManager: ImageManagerDescription {
    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let mainThreadCompletion: ((Result<Data, Error>) -> Void) = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        networkQueue.async {
            guard
                let imageData = try? Data(contentsOf: url)
            else {
                mainThreadCompletion(.failure(ImageManagerError.unexpected))
                return
            }
            
            mainThreadCompletion(.success(imageData))
        }
    }
}
