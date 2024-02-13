//
//  WelcomeView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/18/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                Text("BlinkChat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.orange) 
                
                Image(systemName: "message.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
                
                Text("Connect with Blinking Speed!")
                    .font(.headline)
                    .foregroundColor(.orange.opacity(0.7))
                
                Spacer()
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.purple.opacity(0.7))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                )
                .padding(.horizontal)
                
                NavigationLink(
                    destination: LoginView(),
                    label: {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.orange)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.orange, lineWidth: 3)
                            )
                            .cornerRadius(10)
                    }
                )
                .padding(.horizontal)
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
            )
        }
        .tint(.orange)
        .navigationBarHidden(true)
        .foregroundStyle(.black)
    }
}

#Preview {
    WelcomeView()
}
