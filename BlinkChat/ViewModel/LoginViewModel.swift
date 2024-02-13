//
//  LoginViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/12/24.
//

import Foundation
import FirebaseAuth

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoggedIn = false
    var incorrectCredentials = false
    func login() {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.incorrectCredentials=true
            } else {
                self.isLoggedIn=true
            }
        }
    }
}
