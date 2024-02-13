//
//  MessageTableViewCell.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/4/24.
//

import Foundation

class MessageTableViewCellViewModel{
    let message: MessageModel
    let isCurrentUser:Bool
    init(message: MessageModel, isCurrentUser:Bool) {
        self.message = message
        self.isCurrentUser=isCurrentUser
    }
}
