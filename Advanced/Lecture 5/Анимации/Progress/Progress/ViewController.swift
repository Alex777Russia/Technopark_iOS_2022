//
//  ViewController.swift
//  Progress
//
//  Created by Artur Sardaryan on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let progressView = ProgressView()
    private var progress: ProgressViewProtocol { progressView }
    
    private let startButton = UIButton()
    private let resetButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.addSubview(progressView)
        view.addSubview(startButton)
        view.addSubview(resetButton)
        
        startButton.backgroundColor = .magenta
        startButton.setTitle("Start progress", for: .normal)
        startButton.frame = CGRect(x: 16, y: view.frame.height - 80, width: view.frame.width - 32, height: 40)
        startButton.layer.cornerRadius = 8
        startButton.layer.masksToBounds = true
        
        resetButton.backgroundColor = .magenta
        resetButton.setTitle("Reset progress", for: .normal)
        resetButton.frame = CGRect(x: 16, y: view.frame.height - 128, width: view.frame.width - 32, height: 40)
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
        
        progressView.frame = CGRect(x: 16, y: 80, width: view.frame.width - 32, height: 40)
        
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }

    @objc
    private func didTapStartButton() {
        progress.start()
    }
    
    @objc
    private func didTapResetButton() {
        progress.reset()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        progress.pause()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        progress.resume()
    }
}
