//
//  MessageViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/4/24.
//

import Foundation
import UIKit

@Observable
class MessagesViewModel{
    var chat:ChatLogModel
    var messages:[MessageModel] = []
    var userProfileImageURL:URL?
    var userProfileImage: UIImage?
    var otherUserProfileImage: UIImage?
    var messageText: String = ""
    init(chat: ChatLogModel,imageUrl: URL?) {
        guard let imageUrl=imageUrl else{
            fatalError("Invalid User")
        }
        self.chat = chat
        self.userProfileImageURL=imageUrl
        let path = "profileImages/" + chat.otherUserEmail + "_profilePicture.png"
        StorageMangager.base.getURL(for: path) { url in
            Task{
                do{
                    self.userProfileImage = try await UIImage(data:StorageMangager.base.getImage(imageUrl))
                    self.otherUserProfileImage = try await UIImage(data:StorageMangager.base.getImage(url!))
                }catch{
                    print("Error Getting Images")
                }
            }
        }
        loadMessages()
    }
    func loadMessages(){
        DatabaseManager.base.getMessages(chatID: chat.id, completionHandler: { messageArray in
            if let messageArray = messageArray{
                self.messages=messageArray
            }
        })
    }
    func sendMessage(){
        DatabaseManager.base.addMessage(chatID: chat.id, message: MessageModel(senderEmail: chat.userEmail, message: messageText)) { didSend in
            if didSend{
                self.messageText=""
                self.loadMessages()
            }else{
                print("Error getting messages")
            }
        }
    }
}
