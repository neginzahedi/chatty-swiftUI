//
//  SignInView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var alertMessage: String = ""
    @State private var signInFaildAlert = false

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
                    
                    NavigationLink(destination: ForgotPasswordView()){
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
                NavigationLink(destination: SignUpView()){
                    Text("Sign-up")
                        .foregroundColor(.gray)
                }
                
            }
            
        }.padding()
        
        
    
            .alert(isPresented: self.$signInFaildAlert,
                   content: { self.showAlert() })
        
            .alert(isPresented: self.$signInFaildAlert,
                   content: { self.showAlert() })
        
         
    }
    
    private func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let e = error{
                print("faled log in")
                alertMessage = e.localizedDescription
                signInFaildAlert = true
                return
            }
            
            print("succesfuly log in")
            
        }
    }
    
    func showAlert()-> Alert{
        Alert(
            title: Text("Error"),
            message: Text(self.alertMessage),
            dismissButton: .default(Text("Okay")))
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
