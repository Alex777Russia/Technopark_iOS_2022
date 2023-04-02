//
//  ViewController.swift
//  Posts
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.loadPosts() { result in
            switch result {
            case .success(let posts):
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
