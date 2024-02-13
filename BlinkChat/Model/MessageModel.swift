//
//  MessageModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/3/24.
//

import Foundation

struct MessageModel:Codable,Identifiable{
    let id = UUID()
    let senderEmail:String
    let message:String
}
