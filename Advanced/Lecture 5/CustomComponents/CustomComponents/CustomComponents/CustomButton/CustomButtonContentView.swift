//
//  CustomButtonContentView.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

extension CustomButton {
    final class ContentView: UIView {
        
        private let containerView: UIView = UIView()
        let titleLabel: UILabel = UILabel()
        private let imageView: UIImageView = UIImageView()
        
        // MARK: - Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup
        
        private func setupUI() {
            isUserInteractionEnabled = false
            layer.masksToBounds = true
            
            titleLabel.textAlignment = .center
            imageView.contentMode = .scaleAspectFit
            
            containerView.addSubview(titleLabel)
            containerView.addSubview(imageView)
            addSubview(containerView)
        }
        
        // MARK: - Apply Appearance
        
        func applyAppearance(_ appearance: CustomButton.Appearance) {
            backgroundColor = appearance.background
            layer.cornerRadius = appearance.cornerRadius ?? Constants.defaultCornerRadius
            alpha = appearance.alpha ?? Constants.defaultAlpha
            
            if let borderColor = appearance.borderColor {
                layer.borderColor = borderColor.cgColor
                layer.borderWidth = 1
            }
            
            titleLabel.textColor = appearance.titleColor
            titleLabel.font = appearance.textStyle?.font ?? Constants.defaultTextStyle.font
            
            imageView.image = appearance.image
        }
        
        // MARK: - Layout
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            containerView.pin
                .vCenter()
            
            imageView.pin
                .vCenter()
                .left()
                .size(Constants.defaultImageSize)
            
            let titleLeftEdge = imageView.image == nil ? containerView.edge.left : imageView.edge.right
            let titleMarginLeft: CGFloat = imageView.image == nil ? .zero : 10
            
            titleLabel.pin
                .vCenter()
                .left(to: titleLeftEdge)
                .margin(titleMarginLeft)
                .right()
                .sizeToFit(.widthFlexible)
            
            containerView.pin
                .wrapContent()
                .hCenter()
        }
        
        // MARK: - Constants
        
        private struct Constants {
            static let defaultCornerRadius: CGFloat = 0
            static let defaultAlpha: CGFloat = 1
            static let defaultTextStyle = TextStyle.body1
            static let defaultImageSize: CGSize = CGSize(width: 20, height: 20)
        }
    }
}
