//
//  CreateUserVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closedBtn(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
