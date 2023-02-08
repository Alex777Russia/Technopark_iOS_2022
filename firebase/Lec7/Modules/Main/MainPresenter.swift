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
    func openImagePicker(delegate: ImagePickerDelegate)
    func startActivity()
    func endActivity()
    func show(error: Error)
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
    
    private func loadData() {
        loadPosts()
        loadStories()
    }
    
    func didLoadView() {
        loadData()
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
    
    func didTapCreateStory() {
        output?.openImagePicker(delegate: self)
    }
    
    func didPullToRefresh() {
        loadData()
    }
}

private extension MainPresenter {
    func loadPosts() {
        model.loadPosts(completion: { [weak self] result in
            switch result {
            case .success(let postsNetworkObjects):
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
            case .failure(let error):
                self?.output?.show(error: error)
                
            }
        })
    }
    
    func loadStories() {
        model.loadStories(completion: { [weak self] result in
            switch result {
            case .success(let storiesNetworkObject):
                var storiesViewObjects = [StoryViewObject]()
                
                storiesViewObjects = storiesNetworkObject.map {
                    StoryViewObject(imageName: $0.imageName, image: nil, isViewed: $0.isViewed)
                }
                
                self?.storyViewObjects = storiesViewObjects
                self?.output?.reload()
            case .failure(let error):
                self?.output?.show(error: error)
            }
        })
    }
}

extension MainPresenter: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        
        output?.startActivity()
        model.createStory(image: image) { [weak self] result in
            switch result {
            case .success(let story):
                self?.storyViewObjects.append(.init(imageName: story.imageName, image: nil, isViewed: story.isViewed))
                self?.output?.reload()
            case .failure(let error):
                self?.output?.show(error: error)
            }
            
            self?.output?.endActivity()
        }
    }
}
