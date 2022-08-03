//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// SignUpView has: 1.Image 2.Text 3.TextField 4.Buttons

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var alertMessage: String = ""
    
    @State private var confirmPassAlert = false
    @State private var accountFaildAlert = false
    @State private var accountcreatedAlert = false
    
    
    var body: some View {
        
        // Vertical Contents
        VStack(alignment: .center){
            Image("signup-view-img")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            
            // VStack - Sign-up Field
            VStack(alignment: .leading){
                // Text
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // VStack - username
                VStack(alignment: .leading){
                    // Text
                    Text("Username")
                        .font(.callout)
                        .bold()
                    // TextField
                    TextField("Enter username...", text: $username)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                
                // VStack - email address
                VStack(alignment: .leading){
                    // Text
                    Text("Email")
                        .font(.callout)
                        .bold()
                    // TextField
                    TextField("Enter email address...", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                
                // VStack - password and confirmation
                VStack(alignment: .leading){
                    // Text
                    Text("Password")
                        .font(.callout)
                        .bold()
                    // SecureField
                    SecureField("Enter password...", text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                    
                }.padding(5)
                
                // VStack - confirm password
                VStack(alignment: .leading){
                    // Text
                    Text("Confirm Password")
                        .font(.callout)
                        .bold()
                    // SecureField
                    SecureField("Enter password again...", text: $confirmPassword)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
            }.padding()
            // end of sign-up field
            
            // Button: Sign-up
            Button("Sign Up", action: createAccount)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            
            // HStack - sign in
            HStack(alignment:.center){
                // Text
                Text("I already have an account.")
                // NavigationLink
                NavigationLink(destination: SignInView()){
                    Text("Sign-in")
                        .foregroundColor(.gray)
                }
            }
            
        }.padding()
        // end of content field
        
            .alert("The password confirmation does not match.", isPresented: $confirmPassAlert) {
                Button("Cancel", role: .cancel) { }
            }
        
            .alert(isPresented: self.$accountFaildAlert,
                   content: { self.showAlert() })
        
            .alert(isPresented: self.$accountFaildAlert,
                   content: { self.showAlert() })
        
            .alert(isPresented: self.$accountcreatedAlert,
                   content: { self.showAlert() })
    }
    
    private func createAccount(){
        if password == confirmPassword{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertMessage = "\(e.localizedDescription)"
                    accountFaildAlert = true
                    
                }else{
                    self.alertMessage = "Account created!"
                    accountcreatedAlert = true
                }
            }
        } else{
            self.alertMessage = "The password confirmation does not match."
            self.confirmPassAlert = true
        }
    }
    
    func showAlert()-> Alert{
        Alert(
            title: Text("Error"),
            message: Text(self.alertMessage),
            dismissButton: .default(Text("Okay")))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
