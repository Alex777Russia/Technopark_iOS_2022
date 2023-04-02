//
//  TabBarPresenter.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class TabBarPresenter {
	weak var view: TabBarViewInput?
    weak var moduleOutput: TabBarModuleOutput?

	private let router: TabBarRouterInput
	private let interactor: TabBarInteractorInput

    init(router: TabBarRouterInput, interactor: TabBarInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TabBarPresenter: TabBarModuleInput {
}

extension TabBarPresenter: TabBarViewOutput {
    func shouldSelect(item: TabBarItem) -> Bool {
        let isAuthed = UserDefaults.standard.bool(forKey: "com.sardart.AuthTest.isAuth")
        
        switch item {
        case .products:
            return true
        case .profile:
            if isAuthed {
                return true
            } else {
                router.showAuth(output: self)
                return false
            }
        }
    }
    
    func didLoadView(tabBarController: UITabBarController) {
        router.setupViewControllers(tabBarController: tabBarController)
    }
}

extension TabBarPresenter: TabBarInteractorOutput {
}

extension TabBarPresenter: AuthModuleOutput {
    func didTapAuthButton() {
        
        // go to back
        UserDefaults.standard.set(true, forKey: "com.sardart.AuthTest.isAuth")
        
        router.dismiss()
        router.select(item: .profile)
    }
}
