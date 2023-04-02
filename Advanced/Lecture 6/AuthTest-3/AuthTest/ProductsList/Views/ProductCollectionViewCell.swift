//
//  ProductCollectionViewCell.swift
//  AuthTest
//
//  Created by e.korotkiy on 13.03.2023.
//

import UIKit
import PinLayout

final class ProductCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let productImageView = UINetworkImageView()
    private let favoriteButton = UIButton()
    private let verifiedImageView = UIImageView()
    private let viewedContainerView = UIView()
    private let viewedLabel = UILabel()
    
    private var currentImageURL: String?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .darkGray
        priceLabel.font = .systemFont(ofSize: 19, weight: .medium)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        productImageView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .white
        
        verifiedImageView.image = UIImage(named: "verified")
        
        viewedLabel.text = "ПРОСМОТРЕНО"
        viewedLabel.textColor = .white
        viewedLabel.font = UIFont.systemFont(ofSize: 10)
        viewedContainerView.backgroundColor = .darkGray
        viewedContainerView.alpha = 0.5
        viewedContainerView.layer.cornerRadius = 4
        viewedContainerView.isHidden = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(verifiedImageView)
        
        viewedContainerView.addSubview(viewedLabel)
        contentView.addSubview(viewedContainerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productImageView.pin
            .top()
            .horizontally()
            .bottom(72)
        
        priceLabel.pin
            .below(of: productImageView)
            .marginTop(8)
            .horizontally(8)
            .height(24)
        
        titleLabel.pin
            .below(of: priceLabel)
            .marginTop(8)
            .horizontally(8)
            .height(22)
        
        favoriteButton.pin
            .top(6)
            .right(6)
            .size(24)
        
        verifiedImageView.pin
            .bottom(6 + 72)
            .right(6)
            .size(24)
        
        viewedContainerView.pin
            .topLeft(10)
        
        viewedLabel.pin
            .sizeToFit()
        
        viewedContainerView.pin
            .wrapContent(padding: 4)
    }
    
    func configure(with product: Product) {
        defer {
            setNeedsLayout()
        }
        
        currentImageURL = product.imageUrl
        
        titleLabel.text = product.title
        priceLabel.text = product.price
        verifiedImageView.isHidden = !product.verified
        productImageView.clipsToBounds = true
        viewedContainerView.isHidden = !product.isViewed
        
        favoriteButton.setImage(UIImage(named: product.favorite ? "favoriteInactive" : "favoriteActive"), for: .normal)
        
        if let imageURL = URL(string: product.imageUrl) {
            productImageView.load(from: imageURL)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productImageView.cancelLoadingIfNeeded()
    }
}
