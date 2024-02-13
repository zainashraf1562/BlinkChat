//
//  UserModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/21/24.
//

import Foundation

@Observable
class UserModel: Codable{
    let username: String
    let email: String
    let chats:[ChatLogModel]
    let profileImageUrl:String
    init(username: String, email: String, chats: [ChatLogModel], profileImageUrl: String) {
        self.username = username
        self.email = email
        self.chats = chats
        self.profileImageUrl = profileImageUrl
    }
}
