//
//  ImageManager.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//

import UIKit

protocol ImageManagerDescription {
    func loadImage(with imageURL: URL, uniqueKeyOblect: String, competion: @escaping (Result<UIImage, Error>) -> ())
    func cancel(with imageURL: String, uniqueKeyOblect: String)
}

enum ImageManagerError: LocalizedError {
    case parseError
}

final class ImageManager: ImageManagerDescription {
    private let cacheManager: ImageCacheDescription
    private let networkQueue: OperationQueue
    private let session: URLSession
    
    private let tasksQueue: DispatchQueue = DispatchQueue(label: "ImageManager.tasksQueue", qos: .userInitiated)
    private var tasks: [String: URLSessionTask] = [:]
    
    static let shared: ImageManagerDescription = ImageManager()
    
    private init(cacheManager: ImageCacheDescription = FileManagerImageCache()) {
        self.cacheManager = cacheManager
        self.networkQueue = OperationQueue()
        self.session = URLSession(configuration: .default,
                                  delegate: nil,
                                  delegateQueue: networkQueue)
    }
    
    func loadImage(with imageURL: URL, uniqueKeyOblect: String, competion: @escaping (Result<UIImage, Error>) -> ()) {
        if let cacheImage = cacheManager.obtain(with: imageURL.path()) {
            debugPrint("[DEBUG]: Cache hit")
            competion(.success(cacheImage))
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            let mainThreadCompetion: (Result<UIImage, Error>) -> () = { result in
                DispatchQueue.main.async {
                    competion(result)
                }
            }
            
            if let error = error {
                mainThreadCompetion(.failure(error))
                self?.removeTask(url: imageURL.path(), uniqueKeyOblect: uniqueKeyOblect)
                return
            }
            
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                mainThreadCompetion(.failure(ImageManagerError.parseError))
                self?.removeTask(url: imageURL.path(), uniqueKeyOblect: uniqueKeyOblect)
                return
            }
            
            mainThreadCompetion(.success(image))
            self?.removeTask(url: imageURL.path(), uniqueKeyOblect: uniqueKeyOblect)
            self?.cacheManager.save(object: image, for: imageURL.path())
        }
        
        add(task: task, url: imageURL.path(), uniqueKeyOblect: uniqueKeyOblect)
        
        task.resume()
    }
    
    func cancel(with imageURL: String, uniqueKeyOblect: String) {
        guard let task = tasks[imageURL] else {
            return
        }
        
        task.cancel()
        removeTask(url: imageURL, uniqueKeyOblect: uniqueKeyOblect)
    }
}

private extension ImageManager {
    func add(task: URLSessionTask, url: String, uniqueKeyOblect: String) {
        let key = url + uniqueKeyOblect
        
        tasksQueue.sync {
            let _ = tasks.updateValue(task, forKey: key)
        }
    }
    
    func removeTask(url: String, uniqueKeyOblect: String) {
        let key = url + uniqueKeyOblect
        
        tasksQueue.sync {
            let _ = tasks.removeValue(forKey: key)
        }
    }
}
