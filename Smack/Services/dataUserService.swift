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
    
    
    func returnUiColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        let defaultColor = UIColor.lightGray
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnwrapped = r else { return defaultColor}
        guard let gUnwrapped = g else { return defaultColor}
        guard let bUnwrapped = b else { return defaultColor}
        guard let aUnwrapped = a else { return defaultColor}

        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        
        return newUIColor
    }
    
    
    func logoutUser() {
        id = ""
        name = ""
        email = ""
        avatarName = ""
        avatarColor = ""
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        AuthService.instance.isLoggedIn = false
        messageService.instance.clearChannels()
        messageService.instance.clearMessages()
    }
    
    
    
}
