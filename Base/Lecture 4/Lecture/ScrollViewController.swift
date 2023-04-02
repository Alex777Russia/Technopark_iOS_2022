//
//  ScrollViewController.swift
//  Lecture
//
//  Created by k.kulakov on 25.10.2022.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWholeView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc
    func didTapWholeView() {
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrollView.contentInset.bottom = keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
