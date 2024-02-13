//
//  RegisterViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/22/24.
//

import Foundation
import _PhotosUI_SwiftUI
import FirebaseAuth

@Observable
class RegisterViewModel{
    var selectedItem: PhotosPickerItem? {
        didSet {
            selectedItem?.loadTransferable(type: Data.self, completionHandler: { result in
                switch result{
                case .success(let data):
                    self.selectedImageData=data
                case .failure(let error):
                    fatalError("\(error)")
                }
            })
        }
    }
    var selectedImageData: Data? = nil
    var image:UIImage{
        if let selectedImageData{
            return UIImage(data: selectedImageData)!
        } else{
            return UIImage(systemName: "pencil.circle.fill")!
        }
    }
    
    var username = ""
    var email = ""
    var password = ""
    var isRegistered = false
    var incorrectRegistration = false
    var errorMessage: String = "" {
        didSet{
            incorrectRegistration=true
        }
    }
    
    func register(){
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                let err = error as NSError
                if let authErrorCode = AuthErrorCode.Code(rawValue: err.code) {
                    switch authErrorCode {
                    case .emailAlreadyInUse:
                        errorMessage=RegistrationErrors.emailAlreadyInUse.localizedDescription
                    case .invalidEmail:
                        errorMessage=RegistrationErrors.invalidEmail.localizedDescription
                    case .weakPassword:
                        errorMessage=RegistrationErrors.weakPassword.localizedDescription
                    default:
                        errorMessage=error.localizedDescription
                    }
                    
                }
                errorMessage=error.localizedDescription
            } else{
                if let data = self.image.pngData(){
                    let imageFile = "\(email)_profilePicture.png"
                    StorageMangager.base.storePicture(with: data, fileName: imageFile) { url in
                        let currUser=UserModel(username: self.username, email: self.email, chats: [ChatLogModel](), profileImageUrl: url)
                        DatabaseManager.base.addUser(currUser)
                        self.isRegistered=true
                        UserDefaults.standard.set(self.email, forKey: "userEmail")
                    }
                } else{
                    errorMessage="Corrupted Image"
                }
            }
        }
    }
    
}
enum RegistrationErrors: Error {
    case emailAlreadyInUse
    case invalidEmail
    case weakPassword
    case systemError(message: String)

    var localizedDescription: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email address is already in use."
        case .invalidEmail:
            return "Invalid email address."
        case .weakPassword:
            return "Weak password."
        case .systemError(let message):
            return "System error: \(message)"
        }
    }
}
