//
//  ViewController.swift
//  LikeWorkItem
//
//  Created by k.kulakov on 14.02.2023.
//

import UIKit

final class ApiManager {
    
    var workItems: [String: DispatchWorkItem] = [:]
    var lastUUID: String?
    
    func setLike(isLiked: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("isLiked setted: \(isLiked)")
        
        if let lastUUID = lastUUID {
            let currentWorkItem = workItems[lastUUID]
            currentWorkItem?.cancel()
        }
    
        let uuid = UUID().uuidString
        
        let workItem = DispatchWorkItem {
            sleep(2)
            
            guard self.workItems[uuid]?.isCancelled == false else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(isLiked))
            }
        }
        
        lastUUID = uuid
        workItems[uuid] = workItem
        
        DispatchQueue.global().async(execute: workItem)
    }
}

class ViewController: UIViewController {

    private let api: ApiManager = ApiManager()
    @IBOutlet weak var heartButton: UIButton!
    private var isLikedCurrent: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapHeartButton(_ sender: Any) {
        isLikedCurrent.toggle()
        updateButton(with: isLikedCurrent)
        
        api.setLike(isLiked: isLikedCurrent, completion: { result in
            switch result {
            case .success(let serverIsLiked):
                print("[DEBUG] Server response!")
                self.updateButton(with: serverIsLiked)
            case .failure:
                print("[DEBUG] Error!")
            }
        })
    }
    
    func updateButton(with isLiked: Bool) {
        let imageName: String = isLiked ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

