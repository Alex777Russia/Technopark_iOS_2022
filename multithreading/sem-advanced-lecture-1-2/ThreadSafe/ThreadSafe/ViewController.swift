//
//  ViewController.swift
//  ThreadSafe
//
//  Created by k.kulakov on 14.02.2023.
//

import UIKit

final class ThreadSafeArray<T> {

    private var array: [T] = []
    private let queue = DispatchQueue(label: "ru.ThreadSafeArray", attributes: .concurrent)

    func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }

    func currentValue() -> [T] {
        queue.sync {
            return array
        }
    }
}

class ViewController: UIViewController {
    
    private var array = ThreadSafeArray<String>()
    
    private let queue = DispatchQueue(label: "ru.test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...30 {
            queue.async {
                self.array.append("\(i)")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(self.array.currentValue())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print(self.array.currentValue())
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            print(self.array.currentValue())
        }
    }
}

