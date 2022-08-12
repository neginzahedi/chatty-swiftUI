//
//  ContentView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// NOTES:
// HomeView is used to display SignInView()/SignUpView() by using fullScreenCover

import SwiftUI

struct WelcomeView: View {
    
    // variables to display sign-up/sign-in views if true
    @State private var isSignUpScreen = false
    @State private var isSignInScreen = false
    
    var body: some View {
        
        // Vstack: All contents
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
            
            // Button: to display SignUpView
            Button {
                isSignUpScreen = true
            } label: {
                Text("Get Started")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            
            // Button: to display SignInView
            Button {
                isSignInScreen = true
            } label: {
                Text("Sign In")
                    .foregroundColor(.blue)
                    .font(.headline)
                    .padding()
            }
        }.padding()
        // END of Vstack
        
        
        // fullScreenCover: used to display SignUpView() and SignInView()
        // when isSignUpScreen is true, SignUpView() shows up
            .fullScreenCover(isPresented: $isSignUpScreen){
                SignUpView()
            }
        // when isSignInScreen is true, SignInView() shows up
            .fullScreenCover(isPresented: $isSignInScreen) {
                SignInView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
