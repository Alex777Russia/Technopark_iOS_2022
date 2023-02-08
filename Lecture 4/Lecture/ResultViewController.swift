//
//  ResultViewController.swift
//  Lecture
//
//  Created by k.kulakov on 25.10.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let result = result else {
            return
        }
        
        resultLabel.text = result
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
