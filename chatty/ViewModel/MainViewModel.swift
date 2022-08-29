//
//  MainViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-28.
//

import Foundation
import Firebase

class MainViewModel: ObservableObject {
    
    @Published var currentUser: CurrentUser?
    @Published var userContacts = [""]
    @Published var contacts = [Contact]()
    @Published var isUserLoggedOut: Bool = false
    
    func fetchCurrentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("user id not found in SettingViewModel")
            return
        }
        FirebaseManager.shared.firestoreDB.collection("registeredUsers").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("No data found in document.")
                return
            }
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageURL"] as? String ?? ""
            let status = data["status"] as? String ?? ""
            let uid = data["uid"] as? String ?? ""
            self.userContacts = data["contacts"] as? [String] ?? ["contact"]
            
            self.currentUser = CurrentUser(uid: uid, username: username,email: email, profileImageUrl: profileImageUrl, status: status, contacts: self.userContacts)
        }
    }
    
    func signOutUser(){
        isUserLoggedOut.toggle()
        do {
            try FirebaseManager.shared.auth.signOut()
            print("Signout()")
        } catch let error {
            // handle error here
            print("Error when user try to sign-out: \(error.localizedDescription)")
        }
    }
}
