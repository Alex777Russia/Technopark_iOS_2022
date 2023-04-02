//
//  ProgressView.swift
//  Progress
//
//  Created by Artur Sardaryan on 17.08.2022.
//

import UIKit

protocol ProgressViewProtocol {
    func start()
    func reset()
    func pause()
    func resume()
}

final class ProgressView: UIView {
    private var displayLink: CADisplayLink?
    private var startTime = CFAbsoluteTimeGetCurrent()
    private var pauseTime: CFAbsoluteTime?
    private let duration: CFAbsoluteTime = 5
    
    private var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @objc
    func handleDisplayLink() {
        let progress = (CFAbsoluteTimeGetCurrent() - startTime) / duration
        
        guard progress < 1 else {
            self.progress = 1
            displayLink?.invalidate()
            displayLink = nil
            return
        }
        
        self.progress = progress
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.systemBackground.setFill()
        UIRectFill(rect)
        
        let cornerRadius: CGFloat = 8
        let progressColor = UIColor.magenta
        let backgroundColor = UIColor.systemGray
        
        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        backgroundColor.setFill()
        backgroundPath.fill()
        
        guard progress > 0 else {
            return
        }
        
        let progressRect = CGRect(x: 0, y: 0, width: rect.width * progress, height: rect.height)
        let progressPath = UIBezierPath(roundedRect: progressRect, cornerRadius: cornerRadius)
        progressColor.setFill()
        progressPath.fill()
    }
}

extension ProgressView: ProgressViewProtocol {
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink))
        displayLink?.add(to: .main, forMode: .common)
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func reset() {
        progress = 0
        displayLink?.invalidate()
        displayLink = nil
    }
    
    func pause() {
        displayLink?.isPaused = true
        pauseTime = CFAbsoluteTimeGetCurrent()
    }
    
    func resume() {
        displayLink?.isPaused = false
        
        guard let pauseTime = pauseTime else {
            return
        }
        
        startTime += CFAbsoluteTimeGetCurrent() - pauseTime
        self.pauseTime = nil
    }
}
