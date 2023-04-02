//
//  PostCell.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit
import PinLayout

protocol PostCellDelegate: AnyObject {
    func didLike(post: PostViewObject, isLiked: Bool)
    func didTapMoreButton(post: PostViewObject)
}

final class PostCell: UICollectionViewCell {
    
    private let authorLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    private let likeImageView: UIImageView = UIImageView()
    private let moreImageView: UIImageView = UIImageView()
    
    private var viewObject: PostViewObject?
    
    weak var delegate: PostCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func setup() {
        backgroundColor = .white
        
        layer.cornerRadius = 14
        clipsToBounds = true
        
        authorLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        
        descriptionLabel.font = UIFont(name: "Menlo", size: 16)
        descriptionLabel.numberOfLines = 2
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setupLikeImage))
        likeImageView.addGestureRecognizer(tapRecognizer)
        likeImageView.isUserInteractionEnabled = true
        likeImageView.tintColor = .systemPink
        likeImageView.contentMode = .scaleAspectFit
        
        likeImageView.image = UIImage(systemName: "heart")
        
        moreImageView.image = UIImage(systemName: "ellipsis")
        moreImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMoreImageView)))
        moreImageView.isUserInteractionEnabled = true
        moreImageView.tintColor = UIColor.systemGray
        
        [
            authorLabel,
            descriptionLabel,
            imageView,
            likeImageView,
            moreImageView
        ].forEach(addSubview)
    }
    
    func configure(with viewObject: PostViewObject) {
        self.viewObject = viewObject
        
        authorLabel.text = viewObject.author
        descriptionLabel.text = viewObject.description
        imageView.image = viewObject.image
        
        updateLikeImage(with: viewObject.isLiked)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likeImageView.pin
            .bottomLeft(10)
            .size(CGSize(width: 35, height: 35))
        
        authorLabel.pin
            .topLeft(18)
            .right(10)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: authorLabel)
            .marginTop(16)
            .horizontally(10)
            .sizeToFit(.width)
        
        imageView.pin
            .below(of: descriptionLabel)
            .marginTop(16)
            .above(of: likeImageView)
            .marginBottom(10)
            .horizontally()
        
        moreImageView.pin
            .topRight(18)
            .sizeToFit()
    }
    
    private func updateLikeImage(with isLiked: Bool) {
        likeImageView.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @objc
    private func setupLikeImage() {
        guard let viewObject = viewObject else {
            return
        }
        
        updateLikeImage(with: !viewObject.isLiked)
        delegate?.didLike(post: viewObject, isLiked: !viewObject.isLiked)
    }
    
    @objc
    private func didTapMoreImageView() {
        guard let post = self.viewObject else {
            return
        }
        
        delegate?.didTapMoreButton(post: post)
    }
}
