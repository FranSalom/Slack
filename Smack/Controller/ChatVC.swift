//
//  ChatVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typingUserLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    //Variables
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sendBtn.isHidden = true
        
        
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.dissmiss))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: NOTIF_SELECTED_CHANNEL, object: nil)
        
        SocketService.instance.getChatMessages { (success) in
            if success {
                self.tableView.reloadData()
                let endIndex = IndexPath(row: messageService.instance.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
            }
        }
        
        
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
            tableView.reloadData()
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
                    self.tableView.reloadData()
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
        messageService.instance.clearMessages()
        messageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func dissmiss() {
        view.endEditing(true)
    }
    
    @IBAction func sendMessageBtn(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
        guard let channelId = messageService.instance.channelSelected?.id else { return }
        guard let messageBody = messageTxtBox.text else { return }
        
            SocketService.instance.addMessage(messageBody: messageBody, userId: dataUserService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                }
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = messageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
       } else {
        return UITableViewCell()
        }
        }
    
    
    @IBAction func showBtn(_ sender: Any) {
        if messageTxtBox.text == "" {
            isTyping = false
            sendBtn.isHidden = true
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
            }
            isTyping = true
        }
    }
    
    
    
    
    
    
    
    
    
    
    }
