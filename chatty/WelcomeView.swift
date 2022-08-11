//
//  ContentView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
// HomeView has: 1.Imgae 2.Texts 3.sign-up sign-in buttons

import SwiftUI

struct WelcomeView: View {
    
    @State private var isSignUpSheet = false
    @State private var isSignInSheet = false
    
    var body: some View {
        
        
        VStack{
            
            // Image
            Image("smile")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            // Text
            Text("Connect Together")
                .fontWeight(.heavy)
                .font(.title)
                .padding()
            
            // Text
            Text("Here in chatty, you can talk with your favourite people.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Spacer()
            
            // Button: Display SignUpView
            Button {
                isSignUpSheet = true
            } label: {
                Text("Get Started")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            
            // Button: Display SignInView
            Button {
                isSignInSheet = true
            } label: {
                Text("Sign In")
                    .foregroundColor(.blue)
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isSignUpSheet, content: {
            SignUpView()
        })
        .fullScreenCover(isPresented: $isSignInSheet) {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
