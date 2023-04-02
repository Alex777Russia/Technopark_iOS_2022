//
//  ViewController.swift
//  DispatchGroup
//
//  Created by k.kulakov on 14.02.2023.
//

import UIKit

class ViewController: UIViewController {

    private let manager: CitiesManagerDescription = CitiesManager.shared
    
    @IBOutlet weak var tempLabel: UILabel!
    
    private let queue = DispatchQueue(label: "ru.test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempLabel.text = "Loading..."
        
        let group = DispatchGroup()
        
        var belgorodString: String = ""
        var varaderoString: String = ""
        var moscowString: String = ""
        
        var lastError: Error?
        
        group.enter()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            belgorodString = "test"
            group.leave()
        }
        
        group.enter()
        manager.loadCity(with: "Varadero") { [weak self] result in
            switch result {
            case .success(let data):
                varaderoString = "\(data.name) \(data.main.temp)"
            case .failure(let failure):
                lastError = failure
            }
            
            group.leave()
        }
        
        group.enter()
        manager.loadCity(with: "Moscow") { [weak self] result in
            switch result {
            case .success(let data):
                moscowString = "\(data.name) \(data.main.temp)"
            case .failure(let failure):
                lastError = failure
            }
            
            group.leave()
        }
    
        
        group.notify(queue: queue, timeout: 5.0) { [weak self] isTimeout in
            if let lastError = lastError {
                print("Was error \(lastError)")
                return
            }

            if isTimeout {
                print("Was timeout")
            }
            
            DispatchQueue.main.async {
                self?.tempLabel.text = "\(varaderoString) \(belgorodString) \(moscowString)"
            }
        }
    }
}

extension DispatchGroup {
    func notify(queue: DispatchQueue, timeout: TimeInterval, execute work: @escaping (Bool) -> ()) {
        var selfDestructingCompletion: ((Bool) -> ())?
        
        selfDestructingCompletion = { isTimeout in
            selfDestructingCompletion = nil
            work(isTimeout)
        }
        
        notify(queue: queue) {
            selfDestructingCompletion?(false)
        }
        
        queue.asyncAfter(deadline: .now() + timeout) {
            selfDestructingCompletion?(true)
        }
    }
}
