//
//  SignUpViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-10.
//

import Foundation

class SignUpViewModel : ObservableObject{

    
    @Published var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @Published var isConfirmPassNotSameAlert: Bool = false
    @Published var isCreateAccountFaildAlert: Bool = false
    @Published var isUsernameExist:Bool = false

    // Boolean state that determines whether the MainView() should be visible
    @Published var isMainScreen: Bool = false
    
    // Create user account on Firebase using createUser()
     func createAccount(username: String, email: String, password: String, confirmPassword: String){
        // Check passwords are same
        if password == confirmPassword{
            // check username does not exist in DB
            FirebaseManager.shared.firestoreDB.collection("usernames").document(username).getDocument { documentSnapshot, error in
                if let doc = documentSnapshot{
                    if doc.exists{
                        print("username is duplicated: not available.")
                        self.isUsernameExist = true
                    } else{
                        print("username is unique")
                        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){ authDataResult, error in
                            if let e = error{
                                // if faild to create user account
                                self.alertMessage = "\(e.localizedDescription)"
                                self.isCreateAccountFaildAlert = true
                            }else{
                                // Account created
                                print("Account created!")
                                // save user's info to Firestore DB
                                self.saveUserInfo()
                            }
                        }
                    }
                }
            }
        } else{
            // passwords are not same
            self.isConfirmPassNotSameAlert = true
        }
    }
    
    // Save user's info to cloud firestore db
    func saveUserInfo(){
        //self.addToRegisteredUsers(email: <#String#>, username: <#String#>)
        //addToUsernames()
        print("user saved to firestore db and navigate to MainView()")
        // go to MainView
        isMainScreen.toggle()
    }
    
    // add user info to "registeredUsers" collection
    func addToRegisteredUsers(email: String, username: String){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        FirebaseManager.shared.firestoreDB.collection("registeredUsers").document(userID).setData([
            "uid": userID,
            "email": email.lowercased(),
            "username": username.lowercased().replacingOccurrences(of: " ", with: ""),
            "profileImageURL" : "",
            "status": "Available",
            "contacts": [Any]()
        ]){ error in
            if let e = error{
                print("faild to save user info to firestore db \(e)")
                return
            }
        }
    }
    
    // add username and uid to "usernames" collection
    func addToUsernames(username: String){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        // add email and userid to "emails" collection
        FirebaseManager.shared.firestoreDB.collection("usernames").document(username.lowercased()).setData([
            "username": username.lowercased(),
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
