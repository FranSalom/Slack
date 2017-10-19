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
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func closedBtn(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func crearUsuario(_ sender: Any) {
        
        guard let userName = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        
        
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completition: { (success) in
                    if success {
                        AuthService.instance.addUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(dataUserService.instance.name, dataUserService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    
    
    
    @IBAction func elegirAvatar(_ sender: Any) {
    }
    
    @IBAction func elegirColorAvatar(_ sender: Any) {
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
}
