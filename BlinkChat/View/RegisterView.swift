//
//  RegisterView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/21/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct RegisterView: View {
    @State var viewModel = RegisterViewModel()
    var body: some View {
        VStack{
            Spacer()
            PhotosPicker(selection: $viewModel.selectedItem) {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            TextField("Username", text: $viewModel.username)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
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
                viewModel.register()
            }, label: {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .navigationDestination(isPresented: $viewModel.isRegistered) {
                HomeView(viewModel: HomeViewModel(viewModel.email))
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.incorrectRegistration) {
                Button("OK", role: .cancel) { viewModel.incorrectRegistration = false }
            }
            
            NavigationLink(
                destination: LoginView(),
                label: {
                    Text("Already have a account?")
                        .foregroundStyle(.orange.opacity(0.9))
                        
                }
            )
            .padding(.horizontal)
            Spacer()
            Spacer()
            
        }
        .navigationBarHidden(true)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    RegisterView()
}
