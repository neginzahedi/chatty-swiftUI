//
//  SignUpView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//
/*
 SignUpView: In this view, users can create an account. A username and email are both required to create an account. It checks if the username is available; otherwise, it informs the user to choose a different username. Password and confirm password must match.
 */

import SwiftUI

struct SignUpView: View {
    
    // To change current view
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Firebase Constants
    let const = Constant()
    
    // String states for User inputes
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    // Hide/Show password
    @State private var secured: Bool = true
    
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
                        // replace "whitespace" with _
                            .onChange(of: username) { char in
                                username = char.replacingOccurrences(of: " ", with: "_")
                            }
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
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
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 245.0/255, green: 245.0/255, blue: 245.0),lineWidth: 1))
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
                    createAccount(username: self.username, email: self.email, password: self.password, confirmPassword: self.confirmPassword)
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
                // Button: display signInView()
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
        // check if password and confirm password are same
        if password == confirmPassword {
            // username must be unique: check if username is unique or exists on Database
            FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(username).getDocument { documentSnapshot, error in
                if let doc = documentSnapshot{
                    if doc.exists{
                        print("Faild: username is not available.")
                        // display alert
                        self.alertMessage = "The username is already taken. Choose diffrent username."
                        self.isUsernameExistAlert = true
                    } else{
                        print("Success: username is available.")
                        // 1. CREATE USER
                        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){ authDataResult, error in
                            if let e = error{
                                print("Faild: create an account: \(e)")
                                self.alertMessage = "\(e.localizedDescription)"
                                self.isCreateAccountFaildAlert = true
                            }else{
                                print("Sucess: Account created,user id: \(String(describing: FirebaseManager.shared.auth.currentUser?.uid))")
                                
                                // 2. ADD USER TO DATABSE
                                // current user uid
                                guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
                                // email and password must be lowercase
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
            print("Error: The password confirmation does not match.")
            self.alertMessage = "The password confirmation does not match."
            self.isConfirmPassNotSameAlert = true
        }
    }
    
    // add user to firestore DB collections
    func addUserToDatabase(uid: String, email: String, username: String){
        addTo_users(uid: uid, email: email, username: username)
        addTo_usernames(uid: uid, username: username)
    }
    
    // "users" collection: stores current user's uid,email,username,profileImageURL,status and contacts uid
    func addTo_users(uid: String, email: String, username: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).setData([
            const.collection_users_uid: uid,
            const.collection_users_email: email,
            const.collection_users_username: username,
            const.collection_users_profileImageURL : "",
            const.collection_users_status: "Available",
            const.collection_users_contacts_uid: [Any]()
        ]){ error in
            if let e = error{
                print("Faild: save user to users collection: \(e)")
                return
            }
        }
        print("Success: user saved to users collection.")
    }
    
    // "usernames" collection: stores username and uid
    func addTo_usernames(uid: String, username: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(username).setData([
            const.collection_usernames_username: username,
            const.collection_usernames_uid : uid
        ]){ error in
            if let e = error{
                print("Faild: save user to usernames collection: \(e)")
                return
            }
            print("Success: user saved to usernames collection.")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
