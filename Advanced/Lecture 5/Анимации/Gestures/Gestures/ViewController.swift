//
//  ViewController.swift
//  Gestures
//
//  Created by Artur Sardaryan on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let magicView = MagicView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(magicView)
        magicView.frame = view.bounds
    }
}


final class MagicView: UIView {
    
    // MARK: - Private properties
    
    private let imageView = UIImageView(image: UIImage(named: "1"))
    private let imageContainerView = UIView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
    }
    
    private func layout() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageContainerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageContainerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: imageContainerView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: imageContainerView.rightAnchor).isActive = true
    }
    
    // MARK: - Add Recognizers
    
    private func addGestures() {
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        
        let panGestureRecongizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGestureRecognizer.minimumPressDuration = 1
        
        
        [doubleTapGestureRecognizer, panGestureRecongizer, rotationGestureRecognizer, pinchGestureRecognizer, longPressGestureRecognizer].forEach {
            imageView.addGestureRecognizer($0)
            $0.delegate = self
        }
    }
    
    // MARK: - Handle gestures
    
    @objc
    private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .changed || gestureRecognizer.state == .began else {
            return
        }
        
        if imageView.contentMode == .scaleAspectFill {
            imageView.contentMode = .scaleAspectFit
        } else if imageView.contentMode == .scaleAspectFit {
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    @objc
    private func handlePinch(gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.state == .changed || gestureRecognizer.state == .began else {
            return
        }
        
        gestureRecognizer.view?.transform = gestureRecognizer.view?.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale) ?? .identity
        gestureRecognizer.scale = 1
    }
    
    @objc
    private func handleRotation(gestureRecognizer: UIRotationGestureRecognizer) {
        guard gestureRecognizer.state == .changed || gestureRecognizer.state == .began else {
            return
        }
        
        gestureRecognizer.view?.transform = gestureRecognizer.view?.transform.rotated(by: gestureRecognizer.rotation) ?? .identity
        gestureRecognizer.rotation = 0
    }
    
    @objc
    private func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        
        gestureRecognizer.view?.center.x += translation.x
        gestureRecognizer.view?.center.y += translation.y
        gestureRecognizer.setTranslation(.zero, in: gestureRecognizer.view?.superview)

    }
    
    @objc
    private func handleDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            gestureRecognizer.view?.transform = .identity
            gestureRecognizer.view?.frame = gestureRecognizer.view?.superview?.bounds ?? .zero
        }
    }
}

extension MagicView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
