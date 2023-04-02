//
//  CustomButton.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

final class CustomButton: UIControl {
    enum Size {
        case small
        case medium
        case large
    }
    
    enum Style {
        case primary
        case white
        case red
        case muted
    }
    
    enum State {
        case normal
        case highlighted
        case disabled
    }
    
    override var isEnabled: Bool {
        didSet {
            buttonState = isEnabled ? (isHighlighted ? .highlighted : .normal) : .disabled
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            buttonState = isHighlighted ? .highlighted : (isEnabled ? .normal : .disabled)
        }
    }
    
    // MARK: Private properties
    
    private let contentView = CustomButton.ContentView()
    
    private var normalAppearance: CustomButton.Appearance = .init()
    private var highlightedAppearance: CustomButton.Appearance = .init()
    private var disabledAppearance: CustomButton.Appearance = .init()
    
    private(set) var buttonState: CustomButton.State = .normal {
        didSet {
            applyAppearance()
        }
    }
    
    // MARK: - Init
    
    init(style: CustomButton.Style, size: CustomButton.Size) {
        super.init(frame: .zero)
        
        normalAppearance = Appearance.configure(for: style, size: size, state: .normal)
        highlightedAppearance = Appearance.configure(for: style, size: size, state: .highlighted)
        disabledAppearance = Appearance.configure(for: style, size: size, state: .disabled)
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(contentView)
        
        isAccessibilityElement = true
        applyAppearance()
    }
    
    // MARK: - Configure
    
    func setTitle(_ title: String) {
        accessibilityLabel = title
        accessibilityTraits = .button
        
        contentView.titleLabel.text = title
    }
    
    private func applyAppearance() {
        let appearance: CustomButton.Appearance
        
        switch buttonState {
        case .normal:
            appearance = normalAppearance
        case .highlighted:
            appearance = highlightedAppearance
        case .disabled:
            appearance = disabledAppearance
        }
        
        contentView.applyAppearance(appearance)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin.all()
    }
}
