//
//  SearchViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/1/24.
//

import Foundation

@Observable
class SearchViewModel{
    var searchText = ""
    var users: [UserModel] = []
    var currUser:UserModel? = nil
    init(_ currUser:UserModel?){
        self.currUser=currUser
        DatabaseManager.base.getAllUsers { users in
            if let users = users {
                self.users = users.filter { $0.email != currUser?.email }
            }
        }
    }
    func filteredUsers() -> [UserModel] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.username.localizedCaseInsensitiveContains(searchText) }
        }
    }
    func addUser(_ userModel:UserModel){
        if let currUser = currUser{
            DatabaseManager.base.addChat(ChatLogModel(userEmail: currUser.email, username: currUser.username, otherUserEmail: userModel.email, otherUsername: userModel.username))
        }
    }
}
