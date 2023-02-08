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
    private let mockService: MainServiceDescription = MainMockService()
    
    func loadPosts(completion: @escaping ([PostNetworkObject]) -> Void) {
        service.loadPosts(completion: completion)
    }
    
    func loadStories(completion: @escaping ([StoryNetworkObject]) -> Void) {
        service.loadStories(completion: completion)
    }
}
