//
//  FirebaseManager.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-20.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestoreDB: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestoreDB = Firestore.firestore()
        
        super.init()
    }
}
