//
//  Constants.swift
//  Smack
//
//  Created by Francisco Salom on 16/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import Foundation

typealias completionHandler = (_ Success: Bool) -> ()

// URL
let BASE_URL = "https://chatychatfs.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_USER_LOGIN = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

// Colors
let PURPLE_PLACEHOLDER = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.504494863)

// Segues
let TO_LOGIN = "loginVC"
let CREATE_USER = "createUserVC"
let UNWIND = "unwindSegue"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
    ]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
    
// Notifications
    let USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChange")
    let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
    let NOTIF_SELECTED_CHANNEL = Notification.Name("getChannelName")
   


