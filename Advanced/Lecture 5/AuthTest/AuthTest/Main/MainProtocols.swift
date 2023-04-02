//
//  MainProtocols.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
}

protocol MainViewOutput: AnyObject {
}

protocol MainInteractorInput: AnyObject {
}

protocol MainInteractorOutput: AnyObject {
}

protocol MainRouterInput: AnyObject {
}
