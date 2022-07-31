//
//  SignInView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
      
        VStack(alignment: .center){
            Image("signin-view-img")
                .resizable()
                .scaledToFit()
                .padding(.bottom,50)
            
            // Sign-up VStack
            VStack(alignment: .leading){
                Text("Sign-In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // username
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.callout)
                        .bold()
                    TextField("Enter email ...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        
                }.padding(5)
                
                // password and confirmation
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    SecureField("Enter password ...", text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                    Text("Forget password?")
                        .foregroundColor(.gray)
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
                NavigationLink(destination: SignUpView()){
                    Text("Sign-up")
                        .foregroundColor(.gray)
                }
                
            }
            
        }.padding()
    }
    
    private func signIn(){
        
    }
    
    func createAccount()->Void{
        
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
