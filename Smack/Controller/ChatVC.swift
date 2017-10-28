//
//  ChatVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserbyEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
    }
    
    @objc func userDataDidChange(_ notfif: Notification){
        if AuthService.instance.isLoggedIn{
            onLogInGetMessages()
        } else {
            channelTitle.text = "Please Login"
        }
    }
    
    func onLogInGetMessages(){
        messageService.instance.findChannels { (success) in
            if success {
                // hacer vainas con esto
            }
        }
    }


}
