//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Image("create-img")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Create Accoount")
                .font(.largeTitle)
                .padding()
            Spacer()
            
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .padding()
            TextField("Email", text: $username)
                .disableAutocorrection(true)
                .padding()
            TextField("Password", text: $username)
                .disableAutocorrection(true)
                .padding()
            TextField("Confirm Password", text: $username)
                .disableAutocorrection(true)
                .padding()
            
            // Button: create account
            Button("Sign Up", action: createAccount)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            // sign in
            Button("I already have an account. SignIn", action: createAccount)
        }
    }
    
    func createAccount()-> Void{
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
