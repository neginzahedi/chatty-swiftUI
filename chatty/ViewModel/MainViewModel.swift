//
//  MainViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-28.
//

import Foundation

class MainViewModel: ObservableObject {
 
    // Firebase constants
    let const = Constant()
    
    // current user info
    @Published var currentUser: CurrentUser?
    
    // user's contacts uid
    @Published var contactsUID = [String]()
    
    init(){
        fetchCurrentUser()
    }
    
    func fetchCurrentUser(){
        // current user uid
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Faild: current user uid not found in MainViewModel.")
            return
        }
        
        // fetch user info from "users" collection
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error: fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("Error: No data found in document.")
                return
            }
            
            // current user's info
            let username = data[self.const.collection_users_username] as? String ?? ""
            let email = data[self.const.collection_users_email] as? String ?? ""
            let profileImageUrl = data[self.const.collection_users_profileImageURL] as? String ?? ""
            let status = data[self.const.collection_users_status] as? String ?? ""
            let uid = data[self.const.collection_users_uid] as? String ?? ""
            self.contactsUID = data[self.const.collection_users_contacts_uid] as? [String] ?? [""]
            self.currentUser = CurrentUser(uid: uid, username: username,email: email, profileImageUrl: profileImageUrl, status: status, contacts_uid: self.contactsUID)
        }
    }
    
    
}
