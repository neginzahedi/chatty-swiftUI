//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
// Notes:
// SignUpView: for creating new account and displays MainView() if account successfully created.
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
    
    @State private var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State private var isConfirmPassNotSameAlert = false
    @State private var isCreateAccountFaildAlert = false
    
    // Boolean state that determines whether the MainView() should be visible
    @State private var isMainScreen = false
    
    var body: some View {
        VStack(alignment: .center){
            Image("signup-view-img")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            // Sign-up Field
            VStack(alignment: .leading){
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // username
                VStack(alignment: .leading){
                    HStack{
                        Text("Username")
                            .font(.callout)
                            .bold()
                        Text("(required)")
                            .font(.caption)
                    }
                    TextField("Enter username...", text: $username)
                    //.textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
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
                    //.textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                }.padding(5)
                // password
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
                createAccount()
            } label: {
                Text("Sign Up")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }.disabled(disableSignUpButton)
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
        // END contents
        
        // Alerts:
        // when password and confirm password are not same
            .alert("The password confirmation does not match.", isPresented: $isConfirmPassNotSameAlert) {
                Button("Ok", role: .cancel) { }
            }
        // when faild to create account
            .alert(alertMessage, isPresented: $isCreateAccountFaildAlert){
                Button("Ok", role: .cancel) {}
            }
        
        // fullScreenCover:
        // when isMainScreen is true, MainView() shows up
            .fullScreenCover(isPresented: $isMainScreen) {
                MainView()
            }
    }
    
    // disable sign up button when fields are empty
    var disableSignUpButton: Bool {
        username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
    
    // Create user account on Firebase using createUser()
    private func createAccount(){
        // Check passwords are same
        if password == confirmPassword{
            FirebaseManager.shared.auth.createUser(withEmail: email, password: password){ authDataResult, error in
                if let e = error{
                    // if faild to create user account
                    self.alertMessage = "\(e.localizedDescription)"
                    isCreateAccountFaildAlert = true
                }else{
                    // Account created
                    print("Account created!")
                    // save user's info to Firestore DB
                    saveUserInfo()
                }
            }
        } else{
            // passwords are not same
            self.isConfirmPassNotSameAlert = true
        }
    }
    
    // Save user's info to cloud firestore db
    // TODO: check email format
    private func saveUserInfo(){
        addToRegisteredUsers()
        addToUsernames()
        print("user saved to firestore db and navigate to MainView()")
        // go to MainView
        isMainScreen.toggle()
    }
    
    // add user info to "registeredUsers" collection
    func addToRegisteredUsers(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        FirebaseManager.shared.firestoreDB.collection("registeredUsers").document(userID).setData([
            "uid": userID,
            "email": self.email.lowercased(),
            "username": self.username.lowercased(),
            "profileImageURL" : "",
            "status": "Available"
        ]){ error in
            if let e = error{
                print("faild to save user info to firestore db \(e)")
                return
            }
        }
    }
    
    // add user's username and uid to "usernames" collection
    func addToUsernames(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        // add email and userid to "emails" collection
        FirebaseManager.shared.firestoreDB.collection("usernames").document(self.username.lowercased()).setData([
            "username": self.username.lowercased(),
            "uid" : userID
        ]){ error in
            if let e = error{
                print("faild to save email to firestore db emails \(e)")
                return
            }
            print("user's email and id saved to firestore db.")
            // go to MainView
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
