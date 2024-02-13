//
//  LoginView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/12/24.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    var body: some View {
        VStack{
            Spacer()
            Text("Login to BlinkChat")
                .font(.title.bold())
                .foregroundColor(.orange)
                .padding()
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: {
                viewModel.login()
            }, label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView(viewModel: HomeViewModel(viewModel.email))
            }
            .alert("Incorrect email or password", isPresented: $viewModel.incorrectCredentials) {
                Button("OK", role: .cancel) { viewModel.incorrectCredentials=false }
            }
            
            NavigationLink(
                destination: RegisterView(),
                label: {
                    Text("Don't have a account?")
                        .foregroundStyle(.orange.opacity(0.9))
                        
                }
            )
            .padding(.horizontal)
            Spacer()
            Spacer()
        }
        .navigationBarHidden(true)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    LoginView()
}
