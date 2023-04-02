//
//  MainViewController.swift
//  StudyApplication
//
//  Created by e.korotkiy on 01.11.2022.
//

import UIKit
import PinLayout

final class MainViewController: UIViewController {
    private let titleLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        titleLabel.text = "Hellow, world!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemIndigo
        titleLabel.font = UIFont(name: "Noteworthy", size: 32)
        
        button.backgroundColor = .systemPink.withAlphaComponent(0.8)
        button.setTitle("Tap", for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.pin
            .horizontally(16)
            .vCenter()
            .sizeToFit(.width)
        
        button.pin
            .below(of: titleLabel)
            .marginTop(40)
            .height(42)
            .horizontally(16)
    }
    
    private func setupAnchors() {
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
//        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
//        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
//        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
    }
    
    private func setupConstrains() {
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .centerX,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .centerX,
//                           multiplier: 1,
//                           constant: 0).isActive = true
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .centerY,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .centerY,
//                           multiplier: 1,
//                           constant: 0).isActive = true
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .leading,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .leading,
//                           multiplier: 1,
//                           constant: 16).isActive = true
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .trailing,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .trailing,
//                           multiplier: 1,
//                           constant: -16).isActive = true
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint(item: button,
//                           attribute: .height,
//                           relatedBy: .equal,
//                           toItem: nil,
//                           attribute: .notAnAttribute,
//                           multiplier: 1,
//                           constant: 42).isActive = true
//
//        NSLayoutConstraint(item: button,
//                           attribute: .leading,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .leading,
//                           multiplier: 1,
//                           constant: 16).isActive = true
//
//        NSLayoutConstraint(item: button,
//                           attribute: .trailing,
//                           relatedBy: .equal,
//                           toItem: view,
//                           attribute: .trailing,
//                           multiplier: 1,
//                           constant: -16).isActive = true
//
//        NSLayoutConstraint(item: button,
//                           attribute: .top,
//                           relatedBy: .equal,
//                           toItem: titleLabel,
//                           attribute: .bottom,
//                           multiplier: 1,
//                           constant: 40).isActive = true
    }
    
    @objc
    private func didTapButton() {
        let profileViewController = ProfileViewController()
        
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
}

