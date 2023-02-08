//
//  MyTableViewCell.swift
//  WeatherApp
//
//  Created by Artur Sardaryan on 08.11.2022.
//

import PinLayout
import UIKit
import Kingfisher


final class MyTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let tempLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconImageView)
        
        tempLabel.font = .systemFont(ofSize: 56, weight: .semibold)
        titleLabel.font = .systemFont(ofSize: 32, weight: .medium)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tempLabel.pin
            .sizeToFit()
            .right(12)
            .vCenter()
        
        titleLabel.pin
            .height(32)
            .sizeToFit(.height)
            .left(12)
            .bottom(12)
        
        timeLabel.pin
            .height(24)
            .sizeToFit(.height)
            .left(12)
            .top(12)
        
        iconImageView.pin
            .size(32)
            .after(of: timeLabel, aligned: .center)
    }
    
    func configure(with model: CellModel) {
        titleLabel.text = model.title
        timeLabel.text = model.time
        tempLabel.text = model.temp
        
        iconImageView.kf.setImage(with: model.iconURL)
        
        setNeedsLayout()
    }
}
