//
//  ChatsTableView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/1/24.
//

import SwiftUI

struct ChatsTableView: View {
    @Binding var viewModel: UserModel?
    var body: some View {
        List {
            ForEach(viewModel?.chats ?? []) { chat in
                NavigationLink(
                    destination: MessagesView(viewModel: MessagesViewModel(chat: chat, imageUrl: URL(string: viewModel?.profileImageUrl ?? "" ))),
                    label: {
                        ChatsTableViewCell(viewModel: ChatTableViewCellViewModel(chatLog: chat))
                    }
                )
            }
            
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarBackButtonHidden(true)
    }
}
