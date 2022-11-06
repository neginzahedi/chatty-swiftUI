//
//  MainViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-28.
//

import Foundation
import Firebase
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var currentUser: CurrentUser?
    @Published var contactsUID = [String]()
    
    let const = Constant()
    
    init(){
        fetchCurrentUser()
    }
    
    func fetchCurrentUser(){
        // user uid
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("uid not found in MainViewModel.")
            return
        }
        
        // fetch user info from "users" collection
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching \(uid) document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("No data found in \(uid) document.")
                return
            }
            
            // user's info
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageURL"] as? String ?? ""
            let status = data["status"] as? String ?? ""
            let uid = data["uid"] as? String ?? ""
            self.contactsUID = data["contacts"] as? [String] ?? [""]
            self.currentUser = CurrentUser(uid: uid, username: username,email: email, profileImageUrl: profileImageUrl, status: status, contacts: self.contactsUID)
        }
    }
    
    
}
