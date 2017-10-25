//
//  AuthService.swift
//  Smack
//
//  Created by Francisco Salom on 17/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completition: @escaping completionHandler) {
        
        let lowercasedEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowercasedEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completition(true)
            } else {
                completition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completition: @escaping completionHandler){
        
        let lowercasedEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowercasedEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                
//               if let json = response.result.value as? Dictionary<String, Any> {
//                if let email = json["user"] as? String{
//                    self.userEmail = email
//                }
//
//                if let token = json["token"] as? String{
//                    self.authToken = token
//                }
//                }
                
                //SwiftyJSON manera de hacerlo
                
                guard let data = response.data else { return }
                let json = JSON(data : data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                
                self.isLoggedIn = true
                completition(true)
            } else {
                completition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

    func addUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping completionHandler){
        
        let lowercasedEmail = email.lowercased()
        
        let body: [String:Any] = [
            "name": name,
            "email": lowercasedEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                self.setUserinfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserbyEmail(completion: @escaping completionHandler){
        Alamofire.request("\(URL_USER_LOGIN)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserinfo(data: data)
            completion(true)
        } else {
            completion(false)
        }
    }

        }
    
    
    func setUserinfo(data: Data){
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let color = json["avatarColor"].stringValue
        
        dataUserService.instance.setUserDataService(id: id, name: name, email: email, avatarName: avatarName, color: color)
}
    
    
    
    
}
