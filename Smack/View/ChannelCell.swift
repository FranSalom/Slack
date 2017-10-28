//
//  ChannelCell.swift
//  Smack
//
//  Created by Francisco Salom on 25/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var channelTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configCell(channel: Channels){
       let title = channel.name
        
        channelTitle.text = "#\(title!)"
        
    }

}
