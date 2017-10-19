//
//  dataUserService.swift
//  Smack
//
//  Created by Francisco Salom on 19/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import Foundation

class dataUserService{
    static let instance = dataUserService()
    
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    func setUserDataService(id: String, name: String, email: String, avatarName: String, color: String){
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = color
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
}
