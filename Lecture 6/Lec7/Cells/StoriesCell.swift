//
//  StoriesCell.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

final class StoriesCell: UICollectionViewCell {
    
    private let storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 14
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        collectionView.contentInset = UIEdgeInsets(top: .zero,
                                                   left: 14,
                                                   bottom: .zero,
                                                   right: 14)
        
        return collectionView
    }()
    
    private var viewObjects: [StoryViewObject] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.showsHorizontalScrollIndicator = false
        
        addSubview(storiesCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        storiesCollectionView.pin.all()
    }
    
    func configure(with viewObjects: [StoryViewObject]) {
        self.viewObjects = viewObjects
        self.storiesCollectionView.reloadData()
    }
}

extension StoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewObjects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell",
                                                                for: indexPath) as? StoryCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: StoryViewObject(image: UIImage(systemName: "photo.circle")!, isViewed: true))
            
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell",
                                                                for: indexPath) as? StoryCell,
                viewObjects.count > indexPath.row - 1
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewObjects[indexPath.row - 1])
            
            return cell
        }
    }
}

extension StoriesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 74, height: 74)
    }
}
