//
//  profileViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/10/24.
//

import Foundation
import FirebaseAuth

@Observable
class ProfileViewModel{
    var userWantsToLogout = false
    func logOut(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            userWantsToLogout=false
            
        }catch{
            print("Failed to log out")
        }
    }
}
