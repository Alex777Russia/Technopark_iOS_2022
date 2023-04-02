//
//  UINetworkImageView.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//

import UIKit

final class UINetworkImageView: UIImageView {
    private var actualLoadedURL: String?
    private let uniqueuKeyObject: String = UUID().uuidString
    
    func load(from url: URL) {
        actualLoadedURL = url.path()
        
        ImageManager.shared.loadImage(with: url,
                                      uniqueKeyOblect: uniqueuKeyObject) { [weak self] result in
            guard url.path() == self?.actualLoadedURL else {
                return
            }
            
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                debugPrint("[DEBUG]: Error \(error)")
                self?.image = nil
            }
        }
    }
    
    func cancelLoadingIfNeeded() {
        guard let actualLoadedURL = actualLoadedURL else {
            return
        }
        
        self.actualLoadedURL = nil
        
        ImageManager.shared.cancel(with: actualLoadedURL, uniqueKeyOblect: uniqueuKeyObject)
    }
}
