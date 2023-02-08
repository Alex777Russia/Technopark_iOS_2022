//
//  ServiceCell.swift
//  VK Services
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import UIKit

final class ServiceCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    
    private let iconLoader = IconLoader.shared
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        iconImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.pin
            .left(16)
            .size(40)
            .vCenter()
        
        nameLabel.pin
            .after(of: iconImageView)
            .marginLeft(12)
            .height(24)
            .sizeToFit(.height)
            .vCenter()
    }
    
    func configure(with service: Service) {
        nameLabel.text = service.name
        
        guard let iconUrl = URL(string: service.iconUrl) else {
            return
        }
        
        iconLoader.getImage(with: iconUrl) { [weak self] image in
            self?.iconImageView.image = image
        }
    }
}
