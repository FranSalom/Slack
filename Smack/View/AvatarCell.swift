//
//  AvatarPickCell.swift
//  Smack
//
//  Created by Francisco Salom on 19/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }
    
    func getAvatarType(index: Int, type: AvatarType){
        if type == AvatarType.dark{
            imgCell.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            imgCell.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setViews(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
