//
//  TabBarRouter.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit



final class TabBarRouter {
    weak var tabBarController: UITabBarController?
}

extension TabBarRouter: TabBarRouterInput {
    func showAuth(output: AuthModuleOutput) {
        let authViewController = AuthContainer.assemble(with: .init(moduleOutput: output)).viewController
        let navigationController = UINavigationController(rootViewController: authViewController)
        
        tabBarController?.present(navigationController, animated: true)
    }
    
    func dismiss() {
        tabBarController?.dismiss(animated: true)
    }
    
    func select(item: TabBarItem) {
        tabBarController?.selectedIndex = item.rawValue
    }
    
    func setupViewControllers(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        let items: [TabBarItem] = TabBarItem.allCases
        
        tabBarController.viewControllers = items.map { createViewController(for: $0) }
    }
    
    private func createViewController(for item: TabBarItem) -> UIViewController {
        let viewController: UIViewController
        let tabBarItem = UITabBarItem()
        
        switch item {
        case .products:
            viewController = ProductCollectionContainer.assemble(with: ProductCollectionContext()).viewController
        case .profile:
            viewController = ProfileContainer.assemble(with: .init()).viewController
            tabBarItem.title = "Профиль"
        }
        
        tabBarItem.tag = item.rawValue
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = tabBarItem
        
        return navigationController
    }
    
}
