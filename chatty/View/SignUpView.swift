//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
//  SignUpView: To create an account using Firebase createUser(email,password) method.
//

import SwiftUI

struct SignUpView: View {
    
    // String states for User inputes
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    // Hide/Show password
    @State private var secured: Bool = true
    
    // To change view
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Disable signup button if fields are empty
    var disableButton: Bool {
        username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
    
    // String Alert Message
    @State var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State var isConfirmPassNotSameAlert: Bool = false
    @State var isCreateAccountFaildAlert: Bool = false
    @State var isUsernameExistAlert:Bool = false
    
    // Constants
    let const = Constant()
    
    var body: some View {
        // Main Vstack
        VStack(alignment: .center, spacing: 5){
            //image
            Image("sign-up")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            // Sign-up Vstack
            VStack(alignment: .leading){
                // title
                Text("Sign-up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // User input VStack
                VStack(alignment: .leading, spacing: 5){
                    // Username VStack
                    // TODO: no special char and limited 25
                    VStack(alignment: .leading){
                        // label
                        HStack{
                            Text("Username")
                                .font(.callout)
                                .bold()
                            Text("(required)")
                                .font(.caption)
                        }
                        // Input
                        TextField("Enter username...", text: $username)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
                        // replace "whitespace" with _
                            .onChange(of: username) { char in
                                username = char.replacingOccurrences(of: " ", with: "_")
                            }
                            .padding(10)
                    }.padding(2) // Username VStack
                    
                    // Email VStack
                    VStack(alignment: .leading){
                        // Label
                        HStack{
                            Text("Email")
                                .font(.callout)
                                .bold()
                            Text("(required)")
                                .font(.caption)
                        }
                        // Input
                        TextField("Enter email address...", text: $email)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
                            .padding(10)
                    }.padding(2) // Email VStack
                    
                    // Password VStack
                    VStack(alignment: .leading){
                        // Label
                        Text("Password")
                            .font(.callout)
                            .bold()
                        // Input Zstack
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
                        } //ZStack
                    }.padding(2)
                    
                    // Confirm Password VStack
                    VStack(alignment: .leading){
                        // Label
                        Text("Confirm Password")
                            .font(.callout)
                            .bold()
                        // Input
                        HStack{
                            if self.secured{
                                SecureField("Enter password again...", text: $confirmPassword)
                                    .disableAutocorrection(true)
                            } else {
                                TextField("Enter password again...", text: $confirmPassword)
                                    .disableAutocorrection(true)
                            }
                        } // HStack
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
                    }.padding(2) // Confirm Password VStack
                } // User input VStack
            }.padding() // Sign-up Vstack
            // Buttons Vstack
            VStack{
                // Button to Create Account
                Button {
                    createAccount(username: username, email: email, password: password, confirmPassword: confirmPassword)
                } label: {
                    Text("Sign Up")
                        .font(.body)
                        .bold()
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(.blue)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .padding()
                }.disabled(disableButton)
                // display signInView()
                HStack(alignment:.center){
                    Text("I already have an account.")
                    Button {
                        withAnimation {
                            viewRouter.currentView = .pageSignInView
                        }
                    } label: {
                        Text("Sign-in")
                            .foregroundColor(.gray)
                    }
                } // Hstack
            }.padding() // Buttons Vstack
        }.padding() // Main Vstack
        // alert: passwords are not same
            .alert(alertMessage, isPresented: $isConfirmPassNotSameAlert) {
                Button("Ok", role: .cancel) { }
            }
        // alert: faild to create account
            .alert(alertMessage, isPresented: $isCreateAccountFaildAlert){
                Button("Ok", role: .cancel) {}
            }
        // alert: username is taken
            .alert(alertMessage, isPresented: $isUsernameExistAlert){
                Button("Ok", role: .cancel) {}
            }
    }
    
    // create user on firestore Auth and add user info to firestore collections
    func createAccount(username: String, email: String, password: String, confirmPassword: String){
        if password == confirmPassword {
            // username must be unique: check if username is unique or exists on Database
            FirebaseManager.shared.firestoreDB.collection(const.collection_username_id).document(username).getDocument { documentSnapshot, error in
                if let doc = documentSnapshot{
                    if doc.exists{
                        print("The username is not available.")
                        // display alert
                        self.alertMessage = "The username is already taken. Choose diffrent username."
                        self.isUsernameExistAlert = true
                    } else{
                        print("username is available.")
                        // 1. CREATE USER
                        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){ authDataResult, error in
                            if let e = error{
                                print("Faild to create an account: \(e)")
                                self.alertMessage = "\(e.localizedDescription)"
                                self.isCreateAccountFaildAlert = true
                            }else{
                                print("Account created!")

                                // 2. ADD USER INFO TO DATABSE
                                guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
                                let email = email.lowercased()
                                let username = username.lowercased()
                                addUserToDatabase(uid: userID, email: email, username: username)
                                
                                // 3. NAVIGATE to MainView()
                                withAnimation {
                                    viewRouter.currentView = .pageMainView
                                }
                            }
                        }
                    }
                }
            }
        } else{
            print("The password confirmation does not match.")
            self.alertMessage = "The password confirmation does not match."
            self.isConfirmPassNotSameAlert = true
        }
    }
    
    // add user to firestore DB collections
    func addUserToDatabase(uid: String, email: String, username: String){
        addTo_users(uid: uid, email: email, username: username)
        addTo_username_uid(uid: uid, username: username)
    }
    
    // add user to "users" collection
    // users collection stores all info of a user: uid,email,username,profileImageURL,status and contacts
    func addTo_users(uid: String, email: String, username: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).setData([
            "uid": uid,
            "email": email,
            "username": username,
            "profileImageURL" : "",
            "status": "Available",
            "contacts": [Any]()
        ]){ error in
            if let e = error{
                print("Faild to save user to users collection: \(e)")
                return
            }
        }
    }
    
    // add user to "username_uid" collection
    // username_uid collection stores user's username and uid
    func addTo_username_uid(uid: String, username: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_username_id).document(username).setData([
            "username": username,
            "uid" : uid
        ]){ error in
            if let e = error{
                print("Faild to save user to username_uid collection: \(e)")
                return
            }
            print("username saved to username_uid collection.")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
