//
//  MainModel.swift
//  Lec7
//
//  Created by Andrey Babkov on 29.11.2022.
//

import Foundation
import UIKit

final class MainModel {
    private let service: MainServiceDescription = MainService.shared
    private let imageService = ImageService()
    
    func loadPosts(completion: @escaping (Result<[PostNetworkObject], Error>) -> Void) {
        service.loadPosts { result in
            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }        
    }
    
    func loadStories(completion: @escaping (Result<[StoryNetworkObject], Error>) -> Void) {
        service.loadStories { result in
            switch result {
            case .success(let stories):
                completion(.success(stories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createStory(image: UIImage, completion: @escaping (Result<StoryNetworkObject, Error>) -> Void) {
        imageService.upload(image: image) { [weak self] result in
            switch result {
            case .success(let imageName):
                self?.createStory(imageName: imageName, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createStory(imageName: String, completion: @escaping (Result<StoryNetworkObject, Error>) -> Void) {
        service.create(story: CreateStoryData(imageName: imageName)) { result in
            switch result {
            case .success(let story):
                completion(.success(story))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
