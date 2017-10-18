//
//  CreateUserVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {

    //Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closedBtn(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func crearUsuario(_ sender: Any) {
        
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Registro exitoso!")
            }
        }
    }
    
    @IBAction func elegirAvatar(_ sender: Any) {
    }
    
    @IBAction func elegirColorAvatar(_ sender: Any) {
    }
    
    
    
    
}
