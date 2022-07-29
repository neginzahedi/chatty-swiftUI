//
//  ContentView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            // Image
            Image("main-img")
                .resizable()
                .scaledToFit()
                .frame(width: 250.0, height: 250.0, alignment: .center)
            Spacer()
            // Title
            Text("Connect Together")
                .fontWeight(.heavy)
                .font(.title)
                .padding()
            // Body
            Text("Here in Chatty you can talk with your favourite people.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            Spacer()
            // Button: create account
            Button("Get started", action: createAccount)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            // Button: Sign In
            Button("Sign In", action: signIn)
                .foregroundColor(.blue)
                .font(.headline)
                .padding()
        }
       
    }
    func signIn() -> Void{
        
    }
    
    func createAccount() ->Void{
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
