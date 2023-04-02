//
//  ViewController.swift
//  Lecture
//
//  Created by k.kulakov on 25.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var bigCatImageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWholeView))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        let tapImageViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        bigCatImageView.addGestureRecognizer(tapImageViewGestureRecognizer)
        
        
        bigCatImageView.isUserInteractionEnabled = true
    }
    
    @objc
    func didTapWholeView() {
        view.endEditing(true)
    }
    
    @objc
    func didTapImageView() {
        print(#function)
    }
    
    @IBAction func didTapCalcButton(_ sender: Any) {
        print("[DEBUG] frame \(myView.frame) bounds \(myView.bounds)")
        
        myView.bounds.origin.y += 10
        myView.bounds.origin.x += 10
        
//        guard
//            let firstText = firstTextField.text,
//            let secondText = secondTextField.text,
//            let firstInt: Int = Int(firstText),
//            let secondInt: Int = Int(secondText)
//        else {
//            handleResult(with: "Ошибка!")
//            return
//        }
//
//        guard let action: CalcAction = CalcAction(rawValue: modeSegmentedControl.selectedSegmentIndex) else {
//            handleResult(with: "Неизвестное действие!")
//            return
//        }
//
//        if action == .div && secondInt == 0 {
//            handleResult(with: "Ай, ай, ай! Деление на ноль!")
//            return
//        }
//
//        let result: Int = handleAction(with: action, firstInt, secondInt)
//
//        handleResult(with: "Твой результат \(result)")
    }
    
    func handleAction(with action: CalcAction, _ first: Int, _ second: Int) -> Int {
        switch action {
        case .add:
            return add(first, second)
        case .div:
            return division(first, second)
        case .sub:
            return sub(first, second)
        }
    }
    
    func add(_ first: Int, _ second: Int) -> Int {
        return first + second
    }
    
    func division(_ first: Int, _ second: Int) -> Int {
        return first / second
    }
    
    func sub(_ first: Int, _ second: Int) -> Int {
        return first - second
    }
    
    var result: String = ""
    
    func handleResult(with text: String) {
        result = text
        
        performSegue(withIdentifier: "resultSegue", sender: self)
    }
    
    enum CalcAction: Int {
        case add = 0
        case div = 2
        case sub = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            guard let viewController = segue.destination as? ResultViewController else {
                return
            }
            
            viewController.result = result
        }
    }
}

