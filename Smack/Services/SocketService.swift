//
//  SocketService.swift
//  Smack
//
//  Created by Francisco Salom on 26/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establecerConeccion(){
        socket.connect()
    }
    
    func cerrarConeccion(){
        socket.disconnect()
    }
    
    func addChannels(channelName: String, channelDescription: String, completion: @escaping completionHandler){
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        
    }
    
    func getChannel(completion: @escaping completionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channel_id = dataArray[2] as? String else { return }
            
            let newChannel = Channels(name: channelName, channelDescription: channelDescription, id: channel_id)
            
            messageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping completionHandler){
        
        let user = dataUserService.instance
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    
    func getChatMessages(completion: @escaping completionHandler){
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            if channelId == messageService.instance.channelSelected?.id && AuthService.instance.isLoggedIn {
                let newMessage = Messages(message: msgBody, channelId: channelId, id: id, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                
                messageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
    
    func getypingUsers(_ completionHandler: @escaping (_ typingUsers: [String : String]) -> Void){
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String : String] else { return }
            completionHandler(typingUsers)
        }
        
    }
    
    
    
    
    
    
    

}
