//
//  MainViewController.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    private lazy var presenter = MainPresenter(output: self)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: "StoriesCell")
        
        return collectionView
    }()
    
    private var postViewObjects: [PostViewObject] {
        presenter.postViewObjects
    }
    
    private var storyViewObjects: [StoryViewObject] {
        presenter.storyViewObjects
    }
    
    //stories

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
        
        presenter.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
            .bottom()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postViewObjects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCell",
                                                              for: indexPath) as? StoriesCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: storyViewObjects)
            
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell",
                                                              for: indexPath) as? PostCell,
                postViewObjects.count > indexPath.row - 1
            else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            cell.configure(with: postViewObjects[indexPath.row - 1])
            
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
    func didTapMoreButton(post: PostViewObject) {
        presenter.didTapMoreButton(with: post)
    }
    
    func didLike(post: PostViewObject, isLiked: Bool) {
        presenter.didTapLikeButton(with: isLiked, viewObject: post)
    }
}

extension MainViewController: MainPresenterOutput {
    func reload() {
        collectionView.reloadData()
    }
    
    func reload(indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func deleteCell(at indexPath: IndexPath) {
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    func openMoreMenu(with type: MoreMenuType, post: PostViewObject) {
        let alertViewController = UIAlertController(title: "Меню", message: nil, preferredStyle: .actionSheet)
        
        if case .full = type {
            alertViewController.addAction(UIAlertAction(title: "Открыть пост", style: .default) { [weak self] _ in
                let vc = UIViewController()
                vc.view.backgroundColor = UIColor.systemIndigo
                self?.present(vc, animated: true)
            })
        }
        
        alertViewController.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.presenter.didTapDeleteButton(for: post)
        })
        
        alertViewController.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        
        present(alertViewController, animated: true)
    }
}
