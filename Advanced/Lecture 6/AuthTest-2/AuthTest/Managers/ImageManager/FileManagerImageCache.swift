//
//  FileManagerImageCache.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//

import UIKit

protocol ImageCacheDescription {
    func obtain(with key: String) -> UIImage?
    func save(object: UIImage, for key: String)
}

final class FileManagerImageCache {
    private let fileManager = FileManager.default
    
    private let queue = DispatchQueue(label: "com.sardart.AuthTest.FileManagerImageCache.queue",
                                      qos: .utility,
                                      attributes: [.concurrent])
    
    private func path() -> URL? {
        return try? fileManager.url(for: .cachesDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: true)
    }
    
    private func cleanImageName(with imageName: String) -> String {
        let charSet = CharacterSet.alphanumerics.inverted
        
        return imageName.components(separatedBy: charSet).joined()
    }
}

extension FileManagerImageCache: ImageCacheDescription {
    func obtain(with key: String) -> UIImage? {
        guard let path = path() else {
            return nil
        }
        
        let imageName = cleanImageName(with: key)
        let imagePath = path.appending(path: imageName)
        let isExistInCache = fileManager.fileExists(atPath: imagePath.path())
        debugPrint("FWEFASFA")
        guard
            isExistInCache,
            let data = try? Data(contentsOf: imagePath)
        else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    func save(object: UIImage, for key: String) {
        guard
            let data = object.pngData(),
            let path = path()
        else {
            return
        }
        
        let imageName = cleanImageName(with: key)
        let imagePath = path.appending(path: imageName)
        
        queue.async {
            try? data.write(to: imagePath, options: [.atomic])
        }
    }
}
