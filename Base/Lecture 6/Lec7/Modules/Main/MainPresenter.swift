//
//  MainPresenter.swift
//  Lec7
//
//  Created by Andrey Babkov on 29.11.2022.
//

import Foundation
import UIKit

protocol MainPresenterOutput: AnyObject {
    func reload()
    func reload(indexPath: IndexPath)
    func openMoreMenu(with type: MoreMenuType, post: PostViewObject)
    func deleteCell(at indexPath: IndexPath)
}

enum MoreMenuType {
    case short, full
}

final class MainPresenter {
    private let model = MainModel()
    private weak var output: MainPresenterOutput?
    
    var postViewObjects = [PostViewObject]()
    var storyViewObjects = [StoryViewObject]()
    
    init(output: MainPresenterOutput) {
        self.output = output
    }
    
    func didLoadView() {
        loadPosts()
        loadStories()
    }
    
    func didTapDeleteButton(for post: PostViewObject) {
        guard let (index, _) = postViewObjects.enumerated().first(where: { indexAndViewObject in
            indexAndViewObject.element.id == post.id
        }) else {
            return
        }
            
        postViewObjects.remove(at: index)
        output?.deleteCell(at: IndexPath(row: index + 1, section: 0))
    }
    
    func didTapMoreButton(with post: PostViewObject) {
        var menuType: MoreMenuType
        
        if post.isLiked {
            menuType = .full
        } else {
            menuType = .short
        }
        
        output?.openMoreMenu(with: menuType, post: post)
    }
    
    func didTapLikeButton(with isLiked: Bool, viewObject: PostViewObject) {
        let index = postViewObjects.firstIndex { item in
            viewObject.id == item.id
        }
        
        guard let index = index else {
            return
        }
        
        let viewObject = PostViewObject(
            id: viewObject.id,
            author: viewObject.author,
            description: viewObject.description,
            image: viewObject.image,
            isLiked: !viewObject.isLiked
        )
        
        postViewObjects.remove(at: index)
        postViewObjects.insert(viewObject, at: index)
        
        output?.reload(indexPath: IndexPath(row: index + 1, section: 0))
    }
}

private extension MainPresenter {
    func loadPosts() {
        model.loadPosts(completion: { [weak self] postsNetworkObjects in
            var postsViewObjects = [PostViewObject]()
            
            postsViewObjects = postsNetworkObjects.map { networkObject in
                PostViewObject(
                    id: networkObject.id,
                    author: networkObject.author,
                    description: networkObject.description,
                    image: UIImage(named: networkObject.imageName),
                    isLiked: networkObject.isLiked
                )
            }
            
            self?.postViewObjects = postsViewObjects
            self?.output?.reload()
        })
    }
    
    func loadStories() {
        model.loadStories(completion: { [weak self] storiesNetworkObject in
            var storiesViewObjects = [StoryViewObject]()
            
            storiesViewObjects = storiesNetworkObject.map {
                StoryViewObject(image: UIImage(named: $0.imageName)!, isViewed: $0.isViewed)
            }
            
            self?.storyViewObjects = storiesViewObjects
            self?.output?.reload()
        })
    }
}
