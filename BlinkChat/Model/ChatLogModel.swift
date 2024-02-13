//
//  ChatModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/21/24.
//

import Foundation

struct ChatLogModel:Codable,Identifiable{
    var id:String {
        userEmail<otherUserEmail ? userEmail+otherUserEmail:otherUserEmail+userEmail
    }
    let userEmail:String
    let username:String
    
    let otherUserEmail:String
    let otherUsername:String
}
