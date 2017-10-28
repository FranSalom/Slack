//
//  AddChannelVC.swift
//  Smack
//
//  Created by Francisco Salom on 25/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannel(_ sender: Any) {
        
        guard let channelName = name.text, name.text != "" else { return }
        guard let channelDescription = channelDescription.text else { return }
        
        SocketService.instance.addChannels(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
    }
    
    func setUpView(){
        
    let closeTap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeVentana))
        self.bgView.addGestureRecognizer(closeTap)
        
        name.attributedPlaceholder = NSAttributedString(string: "Nombre del canal", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "Descripcion", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER])
    }
    
    @objc func closeVentana(){
        dismiss(animated: true, completion: nil)
    }
    
}
