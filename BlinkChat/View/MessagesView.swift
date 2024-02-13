//
//  MessagesView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/4/24.
//

import SwiftUI

struct MessagesView: View {
    @State var viewModel:MessagesViewModel
    var body: some View {
        VStack{
            Spacer()
            List {
                ForEach(viewModel.messages) { message in
                    MessageTableViewCell(viewModel: MessageTableViewCellViewModel(message: message , isCurrentUser: message.senderEmail==viewModel.chat.userEmail), uiImage:  message.senderEmail==viewModel.chat.userEmail ? viewModel.userProfileImage : viewModel.otherUserProfileImage)
                }
                .listRowSeparator(.hidden)
            }
            HStack {
                TextField("Type your message...", text: $viewModel.messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.orange)
                
                Button(action: viewModel.sendMessage) {
                    Text("Send")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
