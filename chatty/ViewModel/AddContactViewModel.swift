//
//  AddContactViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-04.
//
// AddContactViewModel: To find if contact username is exist and add it to contact

import Foundation
import Firebase

class AddContactViewModel: ObservableObject {
    
    @Published var isContactFound: Bool = false
    @Published var isContactNotFound: Bool = false
    @Published var isContactAddedAlert: Bool = false
    
    var contactUsername: String = ""
    var contactUserUID: String = ""
    
    let const = Constant()
    
    // Find a contact by "username" in "usernames" DB to check if the user exist
    func findContact(contactUsername: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(contactUsername.lowercased()).getDocument { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("No data found in document.")
                self.isContactNotFound = true
                return
            }
            
            self.isContactFound = true
            self.contactUsername = data[self.const.collection_usernames_username] as? String ?? ""
            self.contactUserUID = data[self.const.collection_usernames_uid] as? String ?? ""
        }
    }
    
    // add new contact uid to the current user's contact list
    func addNewContact(contactUsername: String){
        // current user uid
        guard let currentUseruid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        // add new contact to currentuser contacts list
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(currentUseruid).updateData([
            self.const.collection_users_contacts_uid : FieldValue.arrayUnion([self.contactUserUID])
        ]) { error in
            if let e = error {
                print("Faild: \(e)")
                return
            } else{
                self.isContactAddedAlert = true
                print("Success: new contact added.")
            }
        }
    }
}



