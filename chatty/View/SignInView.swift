//
//  SignInView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// SignInView: Sign-in to created account

import SwiftUI

struct SignInView: View {
    
    // String State for user inputes
    @State private var email: String = ""
    @State private var password: String = ""
    
    // hide/show password
    @State private var secured: Bool = true
    
    // To change view
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Boolean state that determines whether the alert should be visible
    @State var isSignInFaildAlert:Bool = false
    
    // Alert Message
    @State var alertMessage: String = ""
    
    var body: some View {
        // Main VStack
        VStack(alignment: .center){
            // image
            Image("sign-in")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            // SignIn VStack
            VStack(alignment: .leading){
                // Title
                Text("Sign-In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Email VStack
                VStack(alignment: .leading){
                    // Label
                    Text("Email")
                        .font(.callout)
                        .bold()
                    // Input
                    TextField("Enter email ...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }.padding(5) // Email VStack
                // Password VStack
                VStack(alignment: .leading){
                    // Label
                    Text("Password")
                        .font(.callout)
                        .bold()
                    // Input ZStack
                    ZStack{
                        HStack{
                            if self.secured{
                                SecureField("Enter password...", text: $password)
                                    .disableAutocorrection(true)
                            } else {
                                TextField("Enter password...", text: $password)
                                    .disableAutocorrection(true)
                            }
                            Button(action: {
                                self.secured.toggle()
                            }) {
                                Image(systemName: self.secured ? "eye.slash": "eye")
                                    .foregroundColor(.gray)
                            }
                        } // HStack
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
                    } // Input ZStack
                    
                    // Button ForgotPasswordView()
                    Button {
                        withAnimation {
                            viewRouter.currentView = .pageForgotPasswordView
                        }
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.gray)
                    }
                }.padding(5)
            }.padding() // SignIn VStack
            
            Spacer()
            
            // Buttons VStack
            VStack {
                // Button Sign-in
                Button {
                    FirebaseManager.shared.auth.signIn(withEmail: email, password: password){ authResult, error in
                        if let e = error{
                            print("Failed to Sign-in user: \(e)")
                            self.alertMessage = e.localizedDescription
                            self.isSignInFaildAlert = true
                        } else {
                            // go to MaiView()
                            print("User succesfuly logged in.")
                            withAnimation {
                                viewRouter.currentView = .pageMainView
                            }
                        }
                    }
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .bold()
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(.blue)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }.padding()
                
                // Display SignUpView()
                HStack(alignment:.center){
                    Text("Don't have an account?")
                    Button {
                        withAnimation {
                            viewRouter.currentView = .pageSignUpView
                        }
                    } label: {
                        Text("Sign-up")
                            .foregroundColor(.gray)
                    }
                } // HStack
            } // Buttons VStack
        }.padding() // Main VStack
        
        // alert: Display alert if faild to sign in
            .alert(alertMessage, isPresented: $isSignInFaildAlert) {
                Button("Ok", role: .cancel) {}
            }
    }
    
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
