//
//  AnotherOneLibrary.swift
//  AnotherOneLibrary
//
//  Created by o.gibadulin on 28.03.2023.
//

import UIKit

public class Button {
    public static let button: UIButton = {
        let button = UIButton()
        button.setTitle("HELLO WORLD", for: .normal)
        return button
    }()
}
