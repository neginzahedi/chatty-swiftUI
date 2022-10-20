//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
//  SignUpView: Create new account and navigate to MainView() when account successfully created.
//

import SwiftUI

struct SignUpView: View {
    
    // Dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    // String states for User inputes
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @ObservedObject var vm = SignUpViewModel()
    
    // hide/show password
    @State private var secured: Bool = true
    
    
    var body: some View {
        VStack(alignment: .center){
            Image("sign-up")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            // Sign-up Field
            VStack(alignment: .leading){
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // username
                // TODO: no special char and limited 25
                VStack(alignment: .leading){
                    HStack{
                        Text("Username")
                            .font(.callout)
                            .bold()
                        Text("(required)")
                            .font(.caption)
                    }
                    TextField("Enter username...", text: $username)
                        .foregroundColor(.secondary)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: username) { char in
                            username = char.replacingOccurrences(of: " ", with: "_")
                        }
                }.padding(5)
                // email address
                VStack(alignment: .leading){
                    HStack{
                        Text("Email")
                            .font(.callout)
                            .bold()
                        Text("(required)")
                            .font(.caption)
                    }
                    TextField("Enter email address...", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }.padding(5)
                // password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.callout)
                        .bold()
                    
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
                    } //ZStack
                }.padding(5)
                // confirm password
                VStack(alignment: .leading){
                    Text("Confirm Password")
                        .font(.callout)
                        .bold()
                    HStack{
                        if self.secured{
                            SecureField("Enter password again...", text: $confirmPassword)
                                .disableAutocorrection(true)
                        } else {
                            TextField("Enter password again...", text: $confirmPassword)
                                .disableAutocorrection(true)
                        }
                    } // HStack
                }.padding(5)
            }.padding()
            // END Sign-up
            
            // create account
            Button {
                vm.SignUp(username: username, email: email, password: password, confirmPassword: confirmPassword)
            } label: {
                Text("Sign Up")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            // dismiss current view and display welcomeView() again
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
        
        // alert: passwords are not same
            .alert(vm.alertMessage, isPresented: $vm.isConfirmPassNotSameAlert) {
                Button("Ok", role: .cancel) { }
            }
        // alert: faild to create account
            .alert(vm.alertMessage, isPresented: $vm.isCreateAccountFaildAlert){
                Button("Ok", role: .cancel) {}
            }
        // alert: username is taken
            .alert(vm.alertMessage, isPresented: $vm.isUsernameExistAlert){
                Button("Ok", role: .cancel) {}
            }
        
        // fullScreenCover: when isMainScreen is true, MainView() shows up
            .fullScreenCover(isPresented: $vm.isMainScreen) {
                MainView()
            }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            
    }
}
