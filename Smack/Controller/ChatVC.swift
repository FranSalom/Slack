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
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: NOTIF_SELECTED_CHANNEL, object: nil)
        
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
                if messageService.instance.channels.count > 0 {
                    messageService.instance.channelSelected = messageService.instance.channels[0]
                    
                    self.updateWithChannel()
                } else {
                    self.channelTitle.text = "Crea un nuevo canal!"
                }
            }
        }
    }
    
    @objc func channelSelected(){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = messageService.instance.channelSelected?.name ?? ""
        channelTitle.text = "#\(channelName)"
        getChannel()
    }
    
    func getChannel(){
        guard let channelId = messageService.instance.channelSelected?.id else { return }
        
        messageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
    
    
    
    
    
    


}
