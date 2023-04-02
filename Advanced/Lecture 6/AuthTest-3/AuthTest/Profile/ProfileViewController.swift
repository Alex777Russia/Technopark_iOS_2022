//
//  ProfileViewController.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class ProfileViewController: UIViewController {
    private let textField: UITextField = UITextField()
    private let createButton: UIButton = UIButton()
    
	private let output: ProfileViewOutput

    init(output: ProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Профиль"
        
        textField.placeholder = "Введите название"
        
        createButton.setTitle("Создать", for: .normal)
        createButton.backgroundColor = .systemPink.withAlphaComponent(0.8)
        createButton.layer.cornerRadius = 4
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(createButton)
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textField.pin
            .top(view.safeAreaInsets.top + 30)
            .horizontally(30)
            .height(30)
        
        createButton.pin
            .below(of: textField)
            .marginTop(10)
            .horizontally(30)
            .height(30)
    }
    
    @objc
    private func didTapCreateButton() {
        guard
            let text = textField.text,
            !text.isEmpty
        else {
            return
        }
        
        output.didTapSaveButton(with: text)
    }
}

extension ProfileViewController: ProfileViewInput {
}
