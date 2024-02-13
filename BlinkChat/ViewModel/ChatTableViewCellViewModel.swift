//
//  ChatTableViewCellViewModel.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/3/24.
//

import Foundation

@Observable
class ChatTableViewCellViewModel{
    var chatLog: ChatLogModel
    var chatImageURL:URL?
    init(chatLog: ChatLogModel) {
        self.chatLog = chatLog
        let path = "profileImages/" + chatLog.otherUserEmail + "_profilePicture.png"
        StorageMangager.base.getURL(for: path) { url in
            self.chatImageURL=url
        }
        
    }
}
