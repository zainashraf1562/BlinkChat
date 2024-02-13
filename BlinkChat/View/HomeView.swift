//
//  HomeView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    var body: some View {
        TabView {
            ChatsTableView(viewModel: $viewModel.user)
                .tabItem { Label("Chats", systemImage: "message.circle") }
                .onAppear(perform: {
                    viewModel.loadUser()
                })
            
            ProfileView(user: $viewModel.user)
                .tabItem { Label("Profile", systemImage: "person.circle") }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            NavigationLink(
                destination: SearchView(viewModel: SearchViewModel(viewModel.user)),
                label: {
                    Button("Add Chat", systemImage: "plus") {}
                }
            )
        }
    }
}
