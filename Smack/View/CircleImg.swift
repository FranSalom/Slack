//
//  CircleImg.swift
//  Smack
//
//  Created by Francisco Salom on 21/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImg: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
}
