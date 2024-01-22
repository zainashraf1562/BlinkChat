//
//  loginViewModel.swift
//  BlinkChat
//
//  Created by Noman Ashraf on 1/21/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
