//
//  MainViewController.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: "StoriesCell")
//        collectionView.contentInset = UIEdgeInsets(top: 8,
//                                                   left: .zero,
//                                                   bottom: .zero,
//                                                   right: .zero)
        
        return collectionView
    }()
    
    private var models: [PostCellModel] = []

    private func setup() {
        title = "Главная"
        
        view.backgroundColor = .white
        
        collectionView.backgroundColor = .systemGray5
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
            .bottom()
    }

    private func loadPosts() {
        let postModel = PostCellDataModel()
        models = postModel.loadPosts()
    }
    
    private func loadStories() -> [StoryCellModel] {
        let storyModel = StoryCellDataModel()
        return storyModel.loadStroies()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCell",
                                                              for: indexPath) as? StoriesCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: loadStories())
            
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell",
                                                              for: indexPath) as? PostCell,
                models.count > indexPath.row - 1
            else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            cell.configure(with: models[indexPath.row - 1])
            
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: 100)
        } else {
            return CGSize(width: view.frame.width, height: view.frame.width)
        }
    }
}

extension MainViewController: PostCellDelegate {
    func updateModel(with isLiked: Bool, model: PostCellModel) {
        let index = models.firstIndex { item in
            model === item
        }
        
        guard let index = index else {
            return
        }
        
        let cellModel = PostCellModel(author: models[index].author,
                                      description: models[index].description,
                                      image: models[index].image,
                                      isLiked: isLiked)
        models.remove(at: index)
        models.insert(cellModel, at: index)
        
//        collectionView.reloadData()
        
        collectionView.performBatchUpdates {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: index + 1, section: 0)) as? PostCell else {
                return
            }
            
            cell.configure(with: cellModel)
        }
    }
}
