//
//  MainService.swift
//  Lec7
//
//  Created by Andrey Babkov on 29.11.2022.
//
import Foundation
import FirebaseFirestore


protocol MainServiceDescription {
    func create(story: CreateStoryData, completion: @escaping (Result<StoryNetworkObject, Error>) -> Void)
    func loadPosts(completion: @escaping (Result<[PostNetworkObject], Error>) -> Void)
    func loadStories(completion: @escaping (Result<[StoryNetworkObject], Error>) -> Void)
}

enum MainServiceError: Error {
    case noDocuments
}

final class MainService: MainServiceDescription {
    static let shared = MainService()
    
    private let db = Firestore.firestore()
    
    private init() {
        
    }
    
    func create(story: CreateStoryData, completion: @escaping (Result<StoryNetworkObject, Error>) -> Void) {
        var ref: DocumentReference?
        ref = db.collection("stories").addDocument(data: story.dict()) { error in
            if let error = error {
                completion(.failure(error))
            } else if let id = ref?.documentID, let story = StoryNetworkObject(dict: story.dict(), id: id) {
                completion(.success(story))
            } else {
                completion(.failure(MainServiceError.noDocuments))
            }
        }
    }
    
    func loadStories(completion: @escaping (Result<[StoryNetworkObject], Error>) -> Void) {
        db.collection("stories").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(MainServiceError.noDocuments))
                return
            }
            
            let stories = documents.compactMap { StoryNetworkObject(dict: $0.data(), id: $0.documentID) }
            completion(.success(stories))
        }
    }
    
    func loadPosts(completion: @escaping (Result<[PostNetworkObject], Error>) -> Void) {
        db.collection("posts").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(MainServiceError.noDocuments))
                return
            }
            
            let posts = documents.compactMap { PostNetworkObject(dict: $0.data(), id: $0.documentID) }
            completion(.success(posts))
        }
    }
}
