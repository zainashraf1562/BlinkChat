//
//  BlinkChatApp.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/18/24.
//

import SwiftUI
import Firebase

@main
struct BlinkChatApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                WelcomeView()
            }
            .tint(.orange)
            .foregroundStyle(.black)
        }
    }
}
