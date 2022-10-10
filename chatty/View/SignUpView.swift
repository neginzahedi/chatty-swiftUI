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
                        .textFieldStyle(.roundedBorder)
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
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                // password
                // TODO: show password
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
            // END Sign-up
            
            // create account
            Button {
                vm.createAccount(username: username, email: email, password: password, confirmPassword: confirmPassword)
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
            .alert("The password confirmation does not match.", isPresented: $vm.isConfirmPassNotSameAlert) {
                Button("Ok", role: .cancel) { }
            }
        // alert: faild to create account
            .alert(vm.alertMessage, isPresented: $vm.isCreateAccountFaildAlert){
                Button("Ok", role: .cancel) {}
            }
        // alert: username is taken
            .alert("The username is already taken. Choose diffrent username.", isPresented: $vm.isUsernameExist){
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
