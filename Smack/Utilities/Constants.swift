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


// Segues
let TO_LOGIN = "loginVC"
let CREATE_USER = "createUserVC"
let UNWIND = "unwindSegue"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
