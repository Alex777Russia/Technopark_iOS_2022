//
//  IconLoader.swift
//  VK Services
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import UIKit

protocol IconLoaderDescription {
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void)
}

final class IconLoader: IconLoaderDescription {
    static var cache: [String: UIImage] = [:]
    
    static let shared: IconLoaderDescription = IconLoader()
    
    private init() {}
    
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = Self.cache[url.absoluteString] {
            completion(image)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData = try Data(contentsOf: url)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    Self.cache[url.absoluteString] = image
                    completion(image)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
