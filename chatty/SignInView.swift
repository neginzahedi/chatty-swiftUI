//
//  SignInView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// NOTES:
// SignInView to sign in to existing account, display allerts if it goes wrong and navigate to MainView() if user successfully signed in.

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
    @State private var isMainScreen = false
    
    var body: some View {
        VStack(alignment: .center){
            Image("signin-view-img")
                .resizable()
                .scaledToFit()
                .padding(.bottom,50)
            // SignIn Field
            VStack(alignment: .leading){
                Text("Sign-In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Email
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.callout)
                        .bold()
                    TextField("Enter email ...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }.padding(5)
                // password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password ...", text: $password)
                        .textFieldStyle(.roundedBorder)
                    // forgot password button to display ForgotPasswordView()
                    Button {
                        isForgotPasswordScreen = true
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.gray)
                    }
                }.padding(5)
            }.padding()
            // sign in button
            Button("Sign in", action: signIn)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            // dismiss SignInView() to display WelcomeView()
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
        // when $isForgotPasswordScreen is true, ForgotPasswordView() shows up.
            .fullScreenCover(isPresented: $isForgotPasswordScreen){
                ForgotPasswordView()
            }
        // when $isMainScreen is true, MainView() shows up.
            .fullScreenCover(isPresented: $isMainScreen){
                MainView()
            }
    }
    
    // to sign in user with firebase signIn(), display alert if fails and then navigate user to MainView()
    private func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error{
                print("failed log in")
                self.alertMessage = e.localizedDescription
                self.isSignInFaildAlert = true
                return
            }
            // go to MaiView()
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
