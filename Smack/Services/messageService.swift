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
    
    
    func clearChannels(){
        channels.removeAll()
    }
    
    
    
}
