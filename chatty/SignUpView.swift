//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// Notes:
// SignUpView is for creating new account while checking requirements.

import SwiftUI
import Firebase

struct SignUpView: View {
    
    // Dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    // String states for User inputes
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State private var alertMessage: String = ""
    @State private var isConfirmPassNotSameAlert = false
    @State private var isCreateAccountFaildAlert = false
    
    
    var body: some View {
        
        // Vstack: all contents
        VStack(alignment: .center){
            // Image
            Image("signup-view-img")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            
            // VStack: Sign-up Field
            VStack(alignment: .leading){
                
                // Title
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // VStack: username
                VStack(alignment: .leading){
                    Text("Username")
                        .font(.callout)
                        .bold()
                    TextField("Enter username...", text: $username)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                
                // VStack: email address
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.callout)
                        .bold()
                    TextField("Enter email address...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                
                // VStack: password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password...", text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                
                // VStack: confirm password
                VStack(alignment: .leading){
                    Text("Confirm Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password again...", text: $confirmPassword)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
            }.padding()
            // END - sign-up VStack
            
            // Button: to create account
            Button {
                createAccount()
            } label: {
                Text("Sign Up")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            
            // HStack: to dismiss current view and display welcomeView() again
            HStack(alignment:.center){
                Text("I already have an account.")
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Sign-in")
                        .foregroundColor(.gray)
                }
            }
        }.padding()
        // END - all contents Vstack
        
        // Alerts:
        // alert when password and confirm password are not same
            .alert("The password confirmation does not match.", isPresented: $isConfirmPassNotSameAlert) {
                Button("Ok", role: .cancel) { }
            }
        // alert when faild to create account
            .alert(alertMessage, isPresented: $isCreateAccountFaildAlert){
                Button("Ok", role: .cancel) {}
            }
    }
    
    // to create user account on Firebase using createUser method or display alerts if it goes wrong
    private func createAccount(){
        // if password and confirm password are same
        if password == confirmPassword{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    // if faild to create user account
                    self.alertMessage = "\(e.localizedDescription)"
                    isCreateAccountFaildAlert = true
                }else{
                    // if user account successfully created
                    // TODO: go to MainView
                    print("Account created!")
                }
            }
        } else{
            // if password and confirm password are not same
            self.isConfirmPassNotSameAlert = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
