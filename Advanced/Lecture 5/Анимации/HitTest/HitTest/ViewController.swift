//
//  ViewController.swift
//  HitTest
//
//  Created by Artur Sardaryan on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let myButton = MyButton()
    
    private let greenView = MyView()
    private let blueView = MyView()
    private let yellowView = MyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myButton)
        myButton.backgroundColor = .magenta
        myButton.frame = CGRect(x: 40, y: 60, width: 24, height: 24)
        myButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBlackView)))
        
        greenView.name = "Green View"
        greenView.backgroundColor = .green
        put(greenView, into: view, horizontal: 32, vertical: 180)
        greenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGreenView)))
        
        blueView.name = "Blue View"
        blueView.backgroundColor = .blue
        put(blueView, into: greenView, horizontal: 40, vertical: 64)
        blueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBlueView)))
        
        yellowView.name = "Yellow View"
        yellowView.backgroundColor = .yellow
        put(yellowView, into: blueView, horizontal: -80, vertical: 64)
        yellowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapYellowView)))
    }
    
    private func put(_ view: UIView, into superview: UIView, horizontal: CGFloat, vertical: CGFloat) {
        superview.addSubview(view)
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: superview.topAnchor, constant: vertical).isActive = true
        view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -vertical).isActive = true
        view.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: horizontal).isActive = true
        view.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -horizontal).isActive = true
    }
    
    @objc
    private func didTapButton() {
        print("called \(#function)")
    }

    @objc
    private func didTapGreenView() {
        print("called \(#function)")
    }
    
    @objc
    private func didTapBlueView() {
        print("called \(#function)")
    }
    
    @objc
    private func didTapYellowView() {
        print("called \(#function)")
    }
    
    @objc
    private func didTapBlackView() {
        print("called \(#function)")
    }
}

final class MyView: UIView {
    
    var name: String = ""
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("called \(#function)")
        let result = super.hitTest(point, with: event)
        print("result of \(#function) is \(result)")
        return result
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("called \(#function)")
        let result = super.point(inside: point, with: event)
        print("result of \(#function) is \(result)")
        return result
    }
    
    override var debugDescription: String {
        return name
    }
    
}

final class MyButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let touchableArea = CGSize(width: 44, height: 44)
        
        let diffWidth = touchableArea.width - bounds.width
        let diffHeight = touchableArea.height - bounds.height
        
        let newX = bounds.origin.x - diffWidth / 2
        let newY = bounds.origin.y - diffHeight / 2
        
        let newArea = CGRect(x: newX, y: newY, width: touchableArea.width, height: touchableArea.height)
        
        return newArea.contains(point)
    }
}
