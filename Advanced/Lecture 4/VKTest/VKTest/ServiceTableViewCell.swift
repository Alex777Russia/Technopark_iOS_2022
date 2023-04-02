//
//  File.swift
//  VKTest
//
//

import Foundation
import UIKit
import Kingfisher
import PinLayout

final class NetworkImageView: UIImageView {
    private var currentUrl: URL?
    
    func loadImage(with url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        currentUrl = imageURL
        
        ImageManager.shared.loadImage(from: imageURL) { [weak self] result in
            guard imageURL == self?.currentUrl else {
                return
            }
            
            switch result {
            case .success(let imageData):
                self?.image = UIImage(data: imageData)
            case .failure:
                break
            }
        }
    }
}

final class ServiceTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imgService = NetworkImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        
        [titleLabel, descriptionLabel, imgService].forEach {
            containerView.addSubview($0)
        }
        
        contentView.addSubview(containerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        performLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgService.image = nil
    }
    
    private func performLayout() {
        containerView.pin
            .top()
            .horizontally()
        
        imgService.pin
            .top()
            .left(12)
            .size(24)
        
        titleLabel.pin
            .after(of: imgService)
            .top()
            .marginLeft(12)
            .right(12)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: titleLabel)
            .after(of: imgService)
            .marginTop(4)
            .marginLeft(12)
            .right(12)
            .sizeToFit(.width)
        
        containerView.pin
            .wrapContent(.vertically, padding: 12)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        
        return contentView.autoSizeThatFits(size, layoutClosure: performLayout)
    }
    
    func configure(with service: Service) {
        titleLabel.text = service.name
        descriptionLabel.text = service.description
    
        imgService.loadImage(with: service.iconUrl)
    }
}
