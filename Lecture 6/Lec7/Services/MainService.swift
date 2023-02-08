//
//  MainService.swift
//  Lec7
//
//  Created by Andrey Babkov on 29.11.2022.
//
import Foundation


protocol MainServiceDescription {
    func loadPosts(completion: @escaping ([PostNetworkObject]) -> Void)
    func loadStories(completion: @escaping ([StoryNetworkObject]) -> Void)
}

final class MainService: MainServiceDescription {
    static let shared = MainService()
    
    private init() {
        
    }
    
    func loadStories(completion: @escaping ([StoryNetworkObject]) -> Void) {
        let stories: [StoryNetworkObject] = [
            .init(imageName: "cat1", isViewed: false),
            .init(imageName: "cat2", isViewed: false),
            .init(imageName: "cat3", isViewed: false),
            .init(imageName: "cat4", isViewed: false),
            .init(imageName: "cat5", isViewed: false),
            .init(imageName: "cat6", isViewed: false),
            .init(imageName: "cat7", isViewed: false),
            .init(imageName: "cat8", isViewed: false),
            .init(imageName: "cat9", isViewed: false),
            .init(imageName: "cat10", isViewed: false)
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completion(stories)
        }
    }
    
    func loadPosts(completion: @escaping ([PostNetworkObject]) -> Void) {
        let posts: [PostNetworkObject] = [
            .init(
                id: 1,
                author: "Костя",
                description: "Lorem ipsum dolor sit amet.",
                imageName: "cat1",
                isLiked: false),
            .init(
                id: 2,
                author: "Артур",
                description: "Quisque nisl erat",
                imageName: "cat2",
                isLiked: false),
            .init(
                id: 3,
                author: "Андрей",
                description: "",
                imageName: "cat3",
                isLiked: false),
            .init(
                id: 4,
                author: "Семен",
                description: "Nunc congue luctus lacus vitae congue. Fusce sit amet eros placerat, bibendum magna ut, fringilla purus. Donec laoreet sapien venenatis odio luctus posuere. Morbi in lorem odio. Nulla in dolor tortor. Etiam viverra accumsan velit. Duis porta lobortis gravida. Morbi vitae pharetra odio. Nam mi lacus, elementum eu nisl sit amet, finibus dapibus dui.",
                imageName: "cat4",
                isLiked: false),
            .init(
                id: 5,
                author: "Сергей",
                description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos",
                imageName: "cat5",
                isLiked: false),
            .init(
                id: 6,
                author: "Алина",
                description: "Nulla in dolor tortor",
                imageName: "cat6",
                isLiked: false),
            .init(
                id: 7,
                author: "Илья",
                description: "Nam mi lacus, elementum eu nisl sit amet, finibus dapibus dui",
                imageName: "cat7",
                isLiked: false),
            .init(
                id: 8,
                author: "Олег",
                description: "Lorem ipsum",
                imageName: "cat8",
                isLiked: false),
            .init(
                id: 9,
                author: "Паша",
                description: "Mauris suscipit mi sit amet tellus blandit, vel porttitor odio tincidunt",
                imageName: "cat9",
                isLiked: false),
            .init(
                id: 10,
                author: "Макар",
                description: "Pellentesque volutpat viverra lacus",
                imageName: "cat10",
                isLiked: false),
            .init(
                id: 11,
                author: "Даша",
                description: "Fusce sit amet eros placerat",
                imageName: "cat11",
                isLiked: false),
            .init(
                id: 12,
                author: "Вика",
                description: "Curabitur pretium volutpat sollicitudin",
                imageName: "cat12",
                isLiked: false
            )
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completion(posts)
        }
    }
}

final class MainMockService: MainServiceDescription {
    func loadStories(completion: @escaping ([StoryNetworkObject]) -> Void) {
        completion([])
    }
    
    func loadPosts(completion: @escaping ([PostNetworkObject]) -> Void) {
        completion([
            .init(
                id: 12,
                author: "Вика",
                description: "Curabitur pretium volutpat sollicitudin",
                imageName: "cat12",
                isLiked: false
            )
        ])
    }
}

