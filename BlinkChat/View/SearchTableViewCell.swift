//
//  UserTableViewCell.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/1/24.
//

import SwiftUI

struct SearchTableViewCell: View {
    var user:UserModel
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: user.profileImageUrl)) { imagePhase in
                imagePhase.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
            }
            Spacer()
            Text(user.username)
                .font(.title2)
                .foregroundColor(.orange)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    SearchTableViewCell(user: UserModel(username: "User1", email: "User1@gmail.com", chats: [], profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/blinkchat-830dc.appspot.com/o/profileImages%2FUser1@gmail.com_profilePicture.png?alt=media&token=2d7eb171-9bea-428d-936c-d93c38cd5a5a"))
}
