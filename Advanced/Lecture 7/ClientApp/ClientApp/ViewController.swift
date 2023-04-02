//
//  ViewController.swift
//  ClientApp
//
//  Created by o.gibadulin on 28.03.2023.
//

import UIKit
import SomeLibrary
import AnotherOneLibrary
import SomeFramework
import AnotherLibrary

class ViewController: UIViewController {
    
    let button: UIButton = Button.button
    let imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = CustomColor.backgroundColor
        
        imageView.image = AnotherLibrary.image // CustomImages.image
        
        view.addSubview(button)
        view.addSubview(imageView)
        
        
        let pencil = Pencil()
        pencil.write()
        
        print(CustomImages.imageName)
//        print(CustomImages123.imageName)
        
//        print(SomePackage().text)
    }
    
    override func viewWillLayoutSubviews() {
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        imageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
    }

}

//class Pen: Pencil {
//    
//}

