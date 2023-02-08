//
//  PostCell.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit
import PinLayout

protocol PostCellDelegate: AnyObject {
    func updateModel(with isLiked: Bool, model: PostCellModel)
}

final class PostCell: UICollectionViewCell {
    
    private let authorLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    private let likeImageView: UIImageView = UIImageView()
    
    private var model: PostCellModel?
    
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
        
        addSubview(authorLabel)
        addSubview(descriptionLabel)
        addSubview(imageView)
        addSubview(likeImageView)
    }
    
    func configure(with model: PostCellModel) {
        self.model = model
        
        authorLabel.text = model.author
        descriptionLabel.text = model.description
        imageView.image = model.image
        
        updateLikeImage(with: model.isLiked)
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
    }
    
    private func updateLikeImage(with isLiked: Bool) {
        likeImageView.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @objc
    private func setupLikeImage() {
        guard let model = model else {
            return
        }
        
        updateLikeImage(with: !model.isLiked)
        delegate?.updateModel(with: !model.isLiked, model: model)
    }
}
