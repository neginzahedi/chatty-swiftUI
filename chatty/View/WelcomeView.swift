//
//  WelcomeView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// HomeView: Displays SignInView/SignUpView

import SwiftUI

struct WelcomeView: View {
    
    // Boolean states to display fullScreenCover if true
    @State private var isSignUpScreen = false
    @State private var isSignInScreen = false
    
    var body: some View {
        VStack{
            Image("smile")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Text("Connect Together")
                .fontWeight(.heavy)
                .font(.title)
                .padding()
            Text("Here in chatty, you can talk with your favourite people.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            Spacer()
            // Display SignUpView
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
            // Display SignInView
            Button {
                isSignInScreen = true
            } label: {
                Text("Sign In")
                    .foregroundColor(.blue)
                    .font(.headline)
                    .padding()
            }
        }.padding()
        
        // fullScreenCover:
        // isSignUpScreen true, SignUpView() shows up
            .fullScreenCover(isPresented: $isSignUpScreen){
                SignUpView()
            }
        // isSignInScreen true, SignInView() shows up
            .fullScreenCover(isPresented: $isSignInScreen) {
                SignInView()
            }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
