//
//  ChannelVC.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImage: CircleImg!
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeUser(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserData()
    }
    
    @IBAction func addChannelPressedBtn(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
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
    
    @objc func channelsLoaded(_ notif: Notification){
        tableView.reloadData()
    }
    
    func setUpUserData(){
        if AuthService.instance.isLoggedIn {
            avatarImage.image = UIImage(named: dataUserService.instance.avatarName)
            avatarImage.backgroundColor = dataUserService.instance.returnUiColor(components: dataUserService.instance.avatarColor)
            loginButton.setTitle(dataUserService.instance.name, for: .normal)
            
        } else {
            avatarImage.image = UIImage(named: "profileDefault")
            loginButton.setTitle("Login", for: .normal)
            avatarImage.backgroundColor = UIColor.lightGray
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = messageService.instance.channels[indexPath.row]
            cell.configCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
