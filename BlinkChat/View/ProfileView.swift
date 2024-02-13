//
//  ProfileView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/10/24.
//

import SwiftUI

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    @Binding var user:UserModel?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                AsyncImage(url: URL(string: user?.profileImageUrl ?? "")) { imagePhase in
                    switch imagePhase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        case .failure(_):
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        default:
                            Image(systemName: "person.circle")
                    }
                }
                Text(user?.username ?? "")
                    .font(.title)
                    .foregroundColor(.orange)
                Text(user?.email ?? "")
                    .font(.caption)
                    .foregroundColor(.orange)
                Spacer()
                Button(action: {
                    viewModel.userWantsToLogout = true
                }, label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .foregroundColor(.orange)
                        Text("Logout")
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 2)
                    )
                })
                .padding()
                .alert("Do you want to logout?", isPresented: $viewModel.userWantsToLogout) {
                    NavigationLink {
                        WelcomeView()
                    } label: {
                        Button("Yes") {
                            viewModel.logOut()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

