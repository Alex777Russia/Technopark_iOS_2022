//
//  ImagePicker.swift
//  Lec7
//
//  Created by Artur Sardaryan on 20.12.2022.
//

import PhotosUI
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}


final class ImagePicker: NSObject {
    weak var delegate: ImagePickerDelegate?
    
    func present(viewController: UIViewController?) {
        var config = PHPickerConfiguration()
        config.filter = PHPickerFilter.images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        viewController?.present(picker, animated: true)
    }
}

extension ImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [weak self] object, _ in
            let image = object as? UIImage
            DispatchQueue.main.async {
                self?.delegate?.didSelect(image: image)
            }
        })
        
        picker.dismiss(animated: true)
    }
}
