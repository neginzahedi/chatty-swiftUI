//
//  SignInView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// NOTES:
// SignInView to sign in to existing account and display allerts if it goes wrong.

//TODO: Display MainView() if successfully signed in

import SwiftUI
import FirebaseAuth


struct SignInView: View {
    
    // to dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    // String State for user inputes
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State private var isSignInFaildAlert = false
    
    // Boolean state that determines whether the screen should be visible
    @State private var isForgotPasswordScreen = false
    //    @State private var isUserSignedIn = false
    @State private var isMainScreen = false
    
    var body: some View {
        
        // Vstack: all contents
        VStack(alignment: .center){
            Image("signin-view-img")
                .resizable()
                .scaledToFit()
                .padding(.bottom,50)
            
            // VStack: SignIn Field
            VStack(alignment: .leading){
                Text("Sign-In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Vstack: to enter Email
                VStack(alignment: .leading){
                    // label
                    Text("Email")
                        .font(.callout)
                        .bold()
                    // input
                    TextField("Enter email ...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }.padding(5)
                
                // Vstack: to enter password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password ...", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        isForgotPasswordScreen = true
                    } label: {
                        Text("Forget password?")
                            .foregroundColor(.gray)
                        
                    }
                }.padding(5)
                
            }.padding()
            
            
            // Button: create account
            Button("Sign in", action: signIn)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            
            // sign up
            HStack(alignment:.center){
                Text("Don't have an account?")
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Sign-up")
                        .foregroundColor(.gray)
                }
            }
        }.padding()
        
        // Alerts:
        // Display alert if faild to sign in
            .alert(alertMessage, isPresented: $isSignInFaildAlert) {
                Button("Ok", role: .cancel) {}
            }
        
        // fullScreenCover:
        // when $isForgotPasswordScreen is true, ForgotPasswordView() shows up
            .fullScreenCover(isPresented: $isForgotPasswordScreen){
                ForgotPasswordView()
            }
        // when $isMainScreen is true, MainView() shows up
            .fullScreenCover(isPresented: $isMainScreen){
                MainView()
            }
        
        
        
    }
    
    // method to sign in user by using firebase signIn method or display alert if fails
    private func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let e = error{
                print("failed log in")
                self.alertMessage = e.localizedDescription
                self.isSignInFaildAlert = true
                return
            }
            //TODO: go to MainView()
            print("succesfuly log in")
            isMainScreen = true
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
