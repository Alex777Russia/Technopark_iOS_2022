//
//  TabBarProtocols.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case products
    case profile
}

protocol TabBarModuleInput {
	var moduleOutput: TabBarModuleOutput? { get }
}

protocol TabBarModuleOutput: AnyObject {
}

protocol TabBarViewInput: AnyObject {
}

protocol TabBarViewOutput: AnyObject {
    func didLoadView(tabBarController: UITabBarController)
    func shouldSelect(item: TabBarItem) -> Bool
}

protocol TabBarInteractorInput: AnyObject {
}

protocol TabBarInteractorOutput: AnyObject {
}

protocol TabBarRouterInput: AnyObject {
    func showAuth(output: AuthModuleOutput)
    func dismiss()
    func select(item: TabBarItem)
    func setupViewControllers(tabBarController: UITabBarController)
}
