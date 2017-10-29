//
//  MessageCell.swift
//  Smack
//
//  Created by Francisco Salom on 29/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Messages){
        messageLbl.text = message.message
        userName.text = message.userName
        avatarImage.image = UIImage(named: message.userAvatar)
        avatarImage.backgroundColor = dataUserService.instance.returnUiColor(components: message.userAvatarColor)
    }


}
