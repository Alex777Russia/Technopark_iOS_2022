//
//  ViewController.swift
//  OperationQueue
//
//  Created by k.kulakov on 14.02.2023.
//

import UIKit

final class PrintOperation: Operation {
    
    private let queue = DispatchQueue(label: "ru.techpark.PrintOperation", attributes: .concurrent)
    
    let value: Int
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _isExecuting: Bool = false
    override private(set) var isExecuting: Bool {
        get {
            return queue.sync {
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            queue.sync(flags: .barrier) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override private(set) var isFinished: Bool {
        get {
            return queue.sync {
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            queue.sync(flags: .barrier) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    init(value: Int) {
        self.value = value
    }
    
    override func start() {
        print("[DEBUG] Start")
        
        guard !isCancelled else {
            finish()
            return
        }

        isFinished = false
        isExecuting = true
        main()
    }
    
    override func main() {
        print("[DEBUG] \(Thread.current)")
        DispatchQueue.global().async {
            sleep(4)
            
            if !self.isCancelled {
                print(self.value)
            }
            self.finish()
        }
    }
    
    func finish() {
        isExecuting = false
        isFinished = true
    }
}

final class ViewController: UIViewController {

    private let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        queue.maxConcurrentOperationCount = 10
        let myOperations: [PrintOperation] = [PrintOperation(value: 1), PrintOperation(value: 2), PrintOperation(value: 3)]

        queue.addOperations(myOperations, waitUntilFinished: true)
//
        
        print("[DEBUG] All done")
        
//        let operation = {
//            print("[DEBUG] TEST")
//        }
//
//        queue.addOperation(operation)
        
        
//        queue.addOperation {
//            print("[DEBUG] Test 1")
//        }
//
//        queue.addOperation {
//            print("[DEBUG] Test 2")
//        }
//
//        queue.addOperation {
//            print("[DEBUG] Test 3")
//        }
    }


}

