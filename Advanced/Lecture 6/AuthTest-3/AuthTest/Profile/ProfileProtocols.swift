//
//  ProfileProtocols.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
}

protocol ProfileViewOutput: AnyObject {
    func didTapSaveButton(with text: String)
}

protocol ProfileInteractorInput: AnyObject {
    func saveProduct(with name: String)
}

protocol ProfileInteractorOutput: AnyObject {
}

protocol ProfileRouterInput: AnyObject {
}
