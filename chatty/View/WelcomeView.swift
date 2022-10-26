//
//  WelcomeView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//


import SwiftUI

struct WelcomeView: View {
    
    // Change view to SignUpView() or SignInView()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            // Image
            Image("happy")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            // Text 1
            Text("Connect Together")
                .fontWeight(.heavy)
                .font(.title)
                .padding()
            // Text 2
            Text("Here in chatty, you can talk with your favourite people.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            Spacer()
            // Button to display SignUpView()
            Button {
                withAnimation {
                    viewRouter.currentView = .pageSignUpView
                }
            } label: {
                Text("Get Started")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            // Button to display SignInView()
            Button {
                withAnimation {
                    viewRouter.currentView = .pageSignInView
                }
            } label: {
                Text("Sign In")
                    .foregroundColor(.blue)
                    .font(.headline)
                    .padding()
            }
        }.padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
