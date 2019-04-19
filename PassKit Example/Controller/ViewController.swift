//
//  ViewController.swift
//  PassKit Example
//
//  Created by Devansh Vyas on 19/04/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addPressed(_ sender: UIButton) {
        if let path = Bundle.main.path(forResource: "kid", ofType: "pkpass"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let pass = try? PKPass(data: data) {
            let library = PKPassLibrary()
            if !library.containsPass(pass) {
                guard let vc = PKAddPassesViewController(pass: pass) else { return }
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            } else {
                label.text = "Pass already available in Wallet!"
            }
        }
    }
    
}

extension ViewController: PKAddPassesViewControllerDelegate {
    func addPassesViewControllerDidFinish(_ controller: PKAddPassesViewController) {
        label.text = "Pass added successfully!"
        controller.dismiss(animated: true)
    }
}
