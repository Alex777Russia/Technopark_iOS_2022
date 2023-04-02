//
//  AuthInteractor.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import Foundation

final class AuthInteractor {
	weak var output: AuthInteractorOutput?
}

extension AuthInteractor: AuthInteractorInput {
}
