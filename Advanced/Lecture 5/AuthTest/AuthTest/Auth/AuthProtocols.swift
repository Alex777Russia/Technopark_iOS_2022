//
//  AuthProtocols.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

protocol AuthModuleInput {
	var moduleOutput: AuthModuleOutput? { get }
}

protocol AuthModuleOutput: AnyObject {
    func didTapAuthButton()
}

protocol AuthViewInput: AnyObject {
}

protocol AuthViewOutput: AnyObject {
    func didTapButton()
}

protocol AuthInteractorInput: AnyObject {
}

protocol AuthInteractorOutput: AnyObject {
}

protocol AuthRouterInput: AnyObject {
}
