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
    func SignUp(username: String, email: String, password: String, confirmPassword: String){
        if password == confirmPassword {
            // check username
            FirebaseManager.shared.firestoreDB.collection("usernames").document(username).getDocument { documentSnapshot, error in
                if let doc = documentSnapshot{
                    if doc.exists{
                        print("username is duplicated: not available.")
                        self.isUsernameExist = true
                    } else{
                        print("username is unique")
                        
                        // create user and add email/pass to firestore authentication
                        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){ authDataResult, error in
                            if let e = error{
                                // faild to create
                                self.alertMessage = "\(e.localizedDescription)"
                                self.isCreateAccountFaildAlert = true
                            }else{
                                // Account created
                                print("Account created!")
                                guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
                                
                                // add to "registeredUsers" db
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
                                
                                // add to "usernames" db
                                FirebaseManager.shared.firestoreDB.collection("usernames").document(username.lowercased()).setData([
                                    "username": username.lowercased(),
                                    "uid" : userID
                                ]){ error in
                                    if let e = error{
                                        print("faild to save user to usernames db: \(e)")
                                        return
                                    }
                                    print("username saved to usernames db.")
                                }
                                
                                // go to mainview
                                self.isMainScreen.toggle()
                            }
                        }
                    }
                }
            }
        } else{
            self.isConfirmPassNotSameAlert = true
            print("password are not same")
        }
    }
}
