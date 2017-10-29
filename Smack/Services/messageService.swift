//
//  ChannelService.swift
//  Smack
//
//  Created by Francisco Salom on 25/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class messageService {
    static let instance = messageService()
    
    var channels = [Channels]()
    var messages = [Messages]()
    var channelSelected: Channels?
    
    func findChannels(completion: @escaping completionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channels(name: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping completionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let Id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        
                        let message = Messages(message: messageBody, channelId: channelId, id: Id, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)
                }
                
                
                
            } else {
                print(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
    
    
}
