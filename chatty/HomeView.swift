//
//  ContentView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        // Main Page Navigation
        NavigationView {
            
            // VStack for all contents inside
            VStack{
                
                // Image - top image
                Image("main-img")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 100)
                
                Spacer()
                // Title
                Text("Connect Together")
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding()
                // Body
                Text("Here in chatty you can talk with your favourite people.")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Spacer()
                
                // Navigation-Button: create account
                NavigationLink(destination: SignUpView()){
                    Text("Get Started")
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(.blue)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                }
                
                // Navigation-Button: Sign-in to account
                NavigationLink(destination: SignInView()){
                    Text("Sign In")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .padding()
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
