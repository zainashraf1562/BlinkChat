//
//  LoginView.swift
//  BlinkChat
//
//  Created by Noman Ashraf on 1/18/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    let viewModel = LoginViewModel()
    var body: some View {
        VStack{
            Spacer()
            Text("Login to BlinkChat")
                .font(.title.bold())
                .foregroundColor(.orange)
                .padding()
            TextField("Email", text: $email)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: {
                viewModel.login(email: email, password: password) { result in
                    switch result{
                    case .success():
                        isLoggedIn=true
                    case .failure(let error):
                        isLoggedIn=false
                        print("ERROR:\(error)")
                    }
                }
                isLoggedIn=false
            }, label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .navigationDestination(isPresented: $isLoggedIn) {
                ContentView()
            }
            NavigationLink(
                destination: ContentView(),
                label: {
                    Text("Don't Have a account?")
                        .foregroundStyle(.orange.opacity(0.9))
                        
                }
            )
            .padding(.horizontal)
            Spacer()
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    LoginView()
}
