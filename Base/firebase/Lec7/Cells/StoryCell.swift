//
//  StoryCell.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

final class StoryCell: UICollectionViewCell {
    
    private let imageView: UIImageView = UIImageView()
    private let imageService = ImageService()
    
    private var imageName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    private func setup() {
        backgroundColor = .systemGray5
        
        layer.borderWidth = 2
        layer.cornerRadius = frame.width / 2
        tintColor = .systemPink
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = frame.width / 2
        
        addSubview(imageView)
    }
    
    func configure(with viewObject: StoryViewObject) {
        layer.borderColor = viewObject.isViewed ? UIColor.systemGray4.cgColor : UIColor.systemPink.cgColor
        
        imageName = viewObject.imageName
        imageView.image = viewObject.image

        
        guard let imageName = viewObject.imageName else {
            return
        }
        
        imageService.download(imageName: imageName) { [weak self] result in
            guard self?.imageName == viewObject.imageName else {
                return
            }
            
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                break
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.pin.all()
    }
}
