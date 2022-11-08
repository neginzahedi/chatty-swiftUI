//
//  ContactsViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-04.
//

import Foundation

class ContactsViewModel: ObservableObject {
    
    var contactsUID = [""]
    @Published var contacts = [ContactUser]()
    var const = Constant()
    
    func fetchUserContacts(){
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("user id not found in ContactsViewModel")
            return
        }
        
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).getDocument { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("No data found in document.")
                return
            }
            // get all contacts_uid' uid from "contacts_uid"
            self.contactsUID = data[self.const.collection_users_contacts_uid] as? [String] ?? [""]
            
            for contactID in self.contactsUID {
                print(contactID)
                self.getContactInfo(contactID: contactID)
            }
        }
    }
    
    func getContactInfo(contactID: String){
        
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(contactID).getDocument { documentSnapshot, error in
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("No data found in document: here in get conatct info 1")
                return
            }
            
            // set data
            let username = data[self.const.collection_users_username] as? String ?? ""
            let email = data[self.const.collection_users_email] as? String ?? ""
            let profileImageUrl = data[self.const.collection_users_profileImageURL] as? String ?? ""
            let status = data[self.const.collection_users_status] as? String ?? ""
            
            self.contacts.append(ContactUser(uid: contactID, username: username, email: email, profileImageURL: profileImageUrl, status: status))
            print("here in get conatct info")
        }
    }
    
}
