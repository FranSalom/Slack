//
//  ProfileVC.swift
//  Smack
//
//  Created by Francisco Salom on 24/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var yourProfy: UILabel!
    @IBOutlet weak var userNameProfy: UILabel!
    @IBOutlet weak var avatarProfy: UIImageView!
    @IBOutlet weak var emailProfy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.setUpView()
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        dataUserService.instance.logoutUser()
        NotificationCenter.default.post(name: USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
       userNameProfy.text = dataUserService.instance.name
        avatarProfy.image = UIImage(named: dataUserService.instance.avatarName)
       emailProfy.text = dataUserService.instance.email
       avatarProfy.backgroundColor = dataUserService.instance.returnUiColor(components: dataUserService.instance.avatarColor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap))
        bgView.addGestureRecognizer(tap)
        
    }
    
   @objc func closeTap(){
        dismiss(animated: true, completion: nil)
    }
    
    

}
