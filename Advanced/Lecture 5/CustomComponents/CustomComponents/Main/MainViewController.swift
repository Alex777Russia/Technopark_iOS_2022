//
//  MainViewController.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit

final class MainViewController: CustomViewController {
    private let customButton: CustomButton = CustomButton(style: .primary, size: .medium)
    private let customButton2: CustomButton = CustomButton(style: .white, size: .small)
    private let customButton3: CustomButton = CustomButton(style: .muted, size: .large)
    private let customButton4: CustomButton = CustomButton(style: .red, size: .medium)
    private let button: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        customButton.setTitle("Открыть")
        customButton2.setTitle("Создать")
        customButton3.setTitle("Применить")
        customButton4.setTitle("Удалить")
        
//        customButton4.isEnabled = false
        
        button.setTitle("sfsdfs", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.backgroundColor = .accent
        
        view.addSubview(customButton)
        view.addSubview(customButton2)
        view.addSubview(customButton3)
        view.addSubview(customButton4)
        view.addSubview(button)
    
        
                
//        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customButton.pin
            .vCenter()
            .height(42)
            .horizontally(32)
        
        customButton2.pin
            .below(of: customButton)
            .marginTop(10)
            .height(42)
            .horizontally(32)
        
        customButton3.pin
            .below(of: customButton2)
            .marginTop(10)
            .height(42)
            .horizontally(32)
        
        button.pin
            .below(of: customButton3)
            .marginTop(10)
            .height(42)
            .horizontally(32)
    }
    
    private func loadData() {
        showActivity()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.hideActivity()
            self?.showHUD(with: NSError(domain: "Ошибка", code: 400))
        })
    }
    
}
