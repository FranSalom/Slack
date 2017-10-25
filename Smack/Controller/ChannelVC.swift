//
//  ChannelVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImage: CircleImg!
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeUser(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserData()
    }

    @IBAction func loginBtnWasPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    
    @objc func didChangeUser(_ notif: Notification){
       setUpUserData()
    }
    
    func setUpUserData(){
        if AuthService.instance.isLoggedIn {
            avatarImage.image = UIImage(named: dataUserService.instance.avatarName)
            avatarImage.backgroundColor = dataUserService.instance.returnUiColor(components: dataUserService.instance.avatarColor)
            loginButton.setTitle(dataUserService.instance.name, for: .normal)
            print(dataUserService.instance.returnUiColor(components: dataUserService.instance.avatarColor))
        } else {
            avatarImage.image = UIImage(named: "profileDefault")
            loginButton.setTitle("Login", for: .normal)
            avatarImage.backgroundColor = UIColor.lightGray
        }
    }
    
    
    
}
