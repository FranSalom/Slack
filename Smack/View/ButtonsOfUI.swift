//
//  ButtonsOfUI.swift
//  Smack
//
//  Created by Francisco Salom on 18/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonsOfUI: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
       didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }

}
