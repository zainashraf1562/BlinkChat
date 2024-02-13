//
//  DatabaseManager.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/21/24.
//

import Foundation
import FirebaseFirestore

class DatabaseManager{
    private let db = Firestore.firestore()
    static let base = DatabaseManager()
    
    func addUser(_ user:UserModel){
        let docRef = db.collection("Users").document(user.email)
        do {
            try docRef.setData(from: user)
        }
        catch {
            print(error)
        }
    }
    
    func getAllUsers(completionHandler: @escaping ([UserModel]?) -> Void) {
        db.collection("Users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completionHandler(nil)
            } else {
                
                let userModels: [UserModel]? = querySnapshot?.documents.compactMap({ document in
                    if let chatsArray = document.data()["chats"] as? [[String: Any]],
                       let username = document.data()["username"] as? String,
                       let profileImageUrlString = document.data()["profileImageUrl"] as? String{
                        var chats: [ChatLogModel] = []
                        
                        for chatDict in chatsArray {
                            if let otherUserEmail = chatDict["otherUserEmail"] as? String,
                               let otherUsername = chatDict["otherUsername"] as? String {
                                let chat = ChatLogModel(userEmail: document.documentID, username: username, otherUserEmail: otherUserEmail, otherUsername: otherUsername)
                                chats.append(chat)
                            } else {
                                print("Invalid chat dictionary format")
                            }
                        }
                        return UserModel(username: username, email: document.documentID, chats: chats, profileImageUrl: profileImageUrlString)
                    }else{
                        return nil
                    }
                })
                completionHandler(userModels)
            }
        }
    }
    
    func getUser(userEmail: String, completionHandler: @escaping (UserModel?) -> Void) {
        let userRef = db.collection("Users").document(userEmail)
        
        userRef.getDocument { document, error in
            if let error = error {
                print("Error getting user document: \(error)")
                completionHandler(nil)
            } else if let document = document, document.exists {
                if let chatsArray = document.data()?["chats"] as? [[String: Any]],
                   let username = document.data()?["username"] as? String,
                   let profileImageUrlString = document.data()?["profileImageUrl"] as? String{
                    var chats: [ChatLogModel] = []
                    
                    for chatDict in chatsArray {
                        if let otherUserEmail = chatDict["otherUserEmail"] as? String,
                           let otherUsername = chatDict["otherUsername"] as? String {
                            let chat = ChatLogModel(userEmail: userEmail, username: username, otherUserEmail: otherUserEmail, otherUsername: otherUsername)
                            chats.append(chat)
                        } else {
                            print("Invalid chat dictionary format")
                        }
                    }
                    let user = UserModel(username: username, email: userEmail, chats: chats, profileImageUrl: profileImageUrlString)
                    completionHandler(user)
                } else {
                    print("Chats field is nil or not an array")
                    completionHandler(nil)
                }
            } else {
                print("User document does not exist")
                completionHandler(nil)
            }
        }
    }
    
    func addMessage(chatID: String, message: MessageModel, completionHandler: @escaping (Bool) -> Void) {
        let chatRef = db.collection("Chats").document(chatID)
        
        let messageData: [String: Any] = [
            "senderEmail": message.senderEmail,
            "message": message.message
        ]
        
        chatRef.setData([
            "messages": FieldValue.arrayUnion([messageData])
        ], merge: true) { error in
            if let error = error {
                print("Error adding message to chat: \(error)")
                completionHandler(false)
            } else {
                print("Message added to chat successfully")
                completionHandler(true)
            }
        }
    }
    
    func getMessages(chatID: String, completionHandler: @escaping ([MessageModel]?) -> Void) {
        let chatRef = db.collection("Chats").document(chatID)
        
        chatRef.getDocument { document, error in
            if let error = error {
                print("Error getting chat document: \(error)")
                completionHandler(nil)
            } else if let document = document, document.exists {
                if let messageDataArray = document.data()?["messages"] as? [[String: Any]] {
                    
                    var messages: [MessageModel] = []
                    
                    for messageData in messageDataArray {
                        if let senderEmail = messageData["senderEmail"] as? String,
                           let messageString = messageData["message"] as? String {
                            let message = MessageModel(senderEmail: senderEmail, message: messageString)
                            messages.append(message)
                        } else {
                            print("Invalid chat dictionary format")
                        }
                    }
                    
                    completionHandler(messages)
                } else {
                    print("Messages field is not an array")
                    completionHandler(nil)
                }
            } else {
                print("Chat document does not exist")
                completionHandler(nil)
            }
        }
    }
    func addChat(_ chat:ChatLogModel){
        var docRef = db.collection("Users").document(chat.userEmail)
        var chatData: [String: Any] = [
            "userEmail": chat.userEmail,
            "username": chat.username,
            "otherUserEmail": chat.otherUserEmail,
            "otherUsername": chat.otherUsername,
            "id":chat.id
            
        ]
        docRef.updateData([
            "chats": FieldValue.arrayUnion([chatData])
        ]) { error in
            if let error = error {
                print("Error adding message to chat: \(error)")
            } else {
                print("Message added to chat successfully")
            }
        }
        
        docRef = db.collection("Users").document(chat.otherUserEmail)
        chatData = [
            "userEmail": chat.otherUserEmail,
            "username": chat.otherUsername,
            "otherUserEmail": chat.userEmail,
            "otherUsername": chat.username,
            "id":chat.id
            
        ]
        docRef.updateData([
            "chats": FieldValue.arrayUnion([chatData])
        ]) { error in
            if let error = error {
                print("Error adding message to chat: \(error)")
            } else {
                print("Message added to chat successfully")
            }
        }
    }
    
}
