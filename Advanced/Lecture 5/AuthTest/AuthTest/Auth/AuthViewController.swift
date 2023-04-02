//
//  AuthViewController.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class AuthViewController: UIViewController {
	private let output: AuthViewOutput

    init(output: AuthViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        title = "Auth"
        view.backgroundColor = .systemBackground
        
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
        button.frame = .init(x: 40, y: 120, width: 120, height: 40)
	}
    
    @objc
    private func didTapButton() {
        output.didTapButton()
    }
}

extension AuthViewController: AuthViewInput {
}
