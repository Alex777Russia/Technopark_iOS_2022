//
//  CustomButtonAppearance.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

extension CustomButton {
    final class Appearance: NSObject {
        var background: UIColor?
        var cornerRadius: CGFloat?
        var borderColor: UIColor?
        var textStyle: TextStyle?
        var titleColor: UIColor?
        var alpha: CGFloat?
        var image: UIImage?
        
        init(background: UIColor? = nil,
             cornerRadius: CGFloat? = nil,
             borderColor: UIColor? = nil,
             textStyle: TextStyle? = nil,
             titleColor: UIColor? = nil,
             alpha: CGFloat? = nil,
             image: UIImage? = nil) {
            self.background = background
            self.cornerRadius = cornerRadius
            self.textStyle = textStyle
            self.titleColor = titleColor
            self.alpha = alpha
            self.image = image
            
            super.init()
        }
        
        static func configure(for style: CustomButton.Style,
                              size: CustomButton.Size,
                              state: CustomButton.State) -> CustomButton.Appearance {
            var background: UIColor?
            var cornerRadius: CGFloat? = 8
            var borderColor: UIColor?
            var textStyle: TextStyle?
            var titleColor: UIColor?
            var alpha: CGFloat?
            var image: UIImage?
            
            switch style {
            case .primary:
                switch state {
                case .normal:
                    titleColor = .Text.primary.value
                    background = .accent
                case .highlighted:
                    titleColor = .Text.primary.value
                    background = .highlightedAccent
                case .disabled:
                    titleColor = .Text.primary.value
                    background = .highlightedAccent
                    alpha = 0.24
                }
            case .white:
                switch state {
                case .normal:
                    titleColor = .accent
                    background = .UI.backgroundCard.value
                case .highlighted:
                    titleColor = .highlightedAccent
                    background = .UI.backgroundCard2.value
                case .disabled:
                    titleColor = .Text.primary.value
                    background = .UI.backgroundGray.value
                    alpha = 0.24
                }
            case .red:
                switch state {
                case .normal:
                    titleColor = .Text.primary.value
                    background = .UI.error.value
                case .highlighted:
                    titleColor = .Text.secondary.value
                    background = .UI.lightError.value
                case .disabled:
                    titleColor = .Text.primary.value
                    background = .UI.error.value
                    alpha = 0.24
                }
            case .muted:
                titleColor = .Text.secondary.value
                background = .UI.backgroundGray.value
                cornerRadius = 4
                borderColor = .UI.secondary.value
                alpha = 0.4
                image = UIImage(systemName: "plus.circle")
            }
            
            switch size {
            case .small:
                textStyle = .body1
            case .medium:
                textStyle = .title1
            case .large:
                textStyle = .header1
            }
            
            return .init(background: background,
                         cornerRadius: cornerRadius,
                         borderColor: borderColor,
                         textStyle: textStyle,
                         titleColor: titleColor,
                         alpha: alpha,
                         image: image)
        }
    }
}
