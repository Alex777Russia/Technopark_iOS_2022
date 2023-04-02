//
//  AuthPresenter.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

final class AuthPresenter {
	weak var view: AuthViewInput?
    weak var moduleOutput: AuthModuleOutput?

	private let router: AuthRouterInput
	private let interactor: AuthInteractorInput

    init(router: AuthRouterInput, interactor: AuthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthModuleInput {
}

extension AuthPresenter: AuthViewOutput {
    func didTapButton() {
        moduleOutput?.didTapAuthButton()
    }
}

extension AuthPresenter: AuthInteractorOutput {
}
