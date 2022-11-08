//
//  ContactViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-14.
//

import Foundation

class ContactViewModel: ObservableObject {
    
    @Published var contact : ContactUser?
    let const = Constant()
    
    func getContact(uid: String){
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).getDocument { documentSnapshot, error in
            if let document = documentSnapshot, document.exists {
                if let data = document.data() {
                    
                    let username = data[self.const.collection_users_username] as? String ?? ""
                    let email = data[self.const.collection_users_email] as? String ?? ""
                    let profileImageUrl = data[self.const.collection_users_profileImageURL] as? String ?? ""
                    let status = data[self.const.collection_users_status] as? String ?? ""
                    let uid = data[self.const.collection_users_uid] as? String ?? ""
                    self.contact = ContactUser(uid: uid, username: username, email: email, profileImageURL: profileImageUrl, status: status)
                }
            } else {
                print("Error: No document exist: \(String(describing: error))")
            }
        }
    }
}
