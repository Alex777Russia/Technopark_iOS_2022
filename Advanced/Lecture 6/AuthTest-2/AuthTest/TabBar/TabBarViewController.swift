//
//  TabBarViewController.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class TabBarViewController: UITabBarController {
	private let output: TabBarViewOutput

    init(output: TabBarViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        output.didLoadView(tabBarController: self)
        delegate = self
	}
}

extension TabBarViewController: TabBarViewInput {
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let item = TabBarItem(rawValue: viewController.tabBarItem.tag) else {
            return false
        }
        
        return output.shouldSelect(item: item)
    }
}
