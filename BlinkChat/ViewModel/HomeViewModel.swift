//
//  HomeViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/11/24.
//

import Foundation

@Observable
class HomeViewModel{
    var user: UserModel? = nil
    var userEmail:String
    init(_ email:String){
        self.userEmail = email
    }
    func loadUser(){
        DatabaseManager.base.getUser(userEmail: self.userEmail) { user in
            if let user = user{
                self.user=user
            } else{
                print("Error in fetching chats")
            }
        }
    }
}
