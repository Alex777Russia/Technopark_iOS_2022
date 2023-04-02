//
//  CustomViewController.swift
//  CustomComponents
//
//  Created by e.korotkiy on 21.02.2023.
//

import UIKit
import PinLayout

class CustomViewController: UIViewController {
    private let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    private let errorHUDView: ErrorHUDView = ErrorHUDView()
    private let impactFeedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var isPad: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        setupErrorHUDView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicatorView.pin.all()
        
        errorHUDView.pin
            .vCenter()
            .horizontally(32)
            .sizeToFit(.width)
    }
    
    private func setupActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        view.addSubview(activityIndicatorView)
    }
    
    private func setupErrorHUDView() {
        errorHUDView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        errorHUDView.isHidden = true
        errorHUDView.alpha = .zero
//        errorHUDView.configure(with: "PinLayout Warning: width(-30.0) won't be applied,")
        
        view.addSubview(errorHUDView)
    }
    
    func showActivity() {
        activityIndicatorView.startAnimating()
    }
    
    func hideActivity() {
        activityIndicatorView.stopAnimating()
    }
    
    func showHUD(with error: Error) {
        guard errorHUDView.isHidden else {
            return
        }
        
        impactFeedbackGenerator.prepare()
        
        errorHUDView.configure(with: error.localizedDescription)
        errorHUDView.isHidden = false
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        animateShowErrorHUDView()
    }
    
    private func animateShowErrorHUDView() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.errorHUDView.alpha = 1
            
        }) { [weak self] _ in
            self?.impactFeedbackGenerator.impactOccurred()
            self?.animateHideErrorHUDView()
        }
    }
    
    private func animateHideErrorHUDView() {
        UIView.animate(withDuration: 0.6, delay: 3, animations: { [weak self] in
            self?.errorHUDView.alpha = 0
        }) { [weak self] _ in
            self?.errorHUDView.isHidden = true
        }
    }
}
