//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showingAlert = false

    
    var body: some View {
        VStack(alignment: .center){
            Image("signup-view-img")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            
            // Sign-up VStack
            VStack(alignment: .leading){
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // username
                VStack(alignment: .leading){
                    Text("Username")
                        .font(.callout)
                        .bold()
                    TextField("Enter username...", text: $username)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                // email address OR phone number
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.callout)
                        .bold()
                    TextField("Enter email address...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                // password and confirmation
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password...", text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                    
                }.padding(5)
                // confirm password
                VStack(alignment: .leading){
                    Text("Confirm Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password again...", text: $confirmPassword)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
            }.padding()
            
            
            // Button: create account
            Button("Sign Up", action: createAccount)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            // sign in
            HStack(alignment:.center){
                Text("I already have an account.")
                NavigationLink(destination: SignInView()){
                    Text("Sign-in")
                        .foregroundColor(.gray)
                }
            }
            
        }.padding()
        
            .alert("Password and confirm password are not same.", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) { }
            }
        
    }
    
    private func createAccount(){
        if password == confirmPassword{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print("Failed to create user: \(e)")
                }else{
                    print("new user account created.\(authResult?.user.uid ?? "")")
                }
            }
        } else{
            showingAlert = true
            print("passwords are not same.")
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
