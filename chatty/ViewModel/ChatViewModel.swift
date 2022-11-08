//
//  ChatViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-09-01.
//

import Foundation
import Firebase

class ChatViewModel: ObservableObject {
    
    // Firebase constants
    var const = Constant()
    
    @Published var count = 0
    
    // array of type ChatMessage
    @Published var chatMessages = [ChatMessage]()
    
    // array of type ChatMessage
    let contact : ContactUser?
    
    init(contact: ContactUser?){
        self.contact = contact
        fetchMessages()
    }
    
    // fetch messages from database "messages"
    func fetchMessages(){
        
        // fromID: current signed-in user uid
        guard let fromUserID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        // toID: contact uid
        guard let toUserID =  self.contact?.uid else {return}
        
        // get data from db
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(fromUserID)
            .collection(toUserID)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("Faild: Fetching messages.")
                    print(e.localizedDescription)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        let docID = change.document.documentID
                        let chatMessage = ChatMessage(documentID: docID, data: data)
                        self.chatMessages.append(chatMessage)
                    }
                })
            }
        // scroll page to bottom
        
    }
    
    // save new message to database "messages"
    func sendMessage(contactUID: String, text: String) {
        
        // fromID: current user uid
        guard let fromUserID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        // find contact user send message to is to user
        FirebaseManager.shared.firestoreDB.collection("usernames").document(chatUser).getDocument { documentSnapshot, error in
            if let e = error {
                print("error fetch data in SettingViewModel: \(e)")
                return
            }
            guard let data = documentSnapshot?.data()
            else {
                print("No data found for current user usernames collection")
                return
            }
            let toUserID = data["uid"] as? String ?? ""
            
            // "messages" collection saves messages
            let document = FirebaseManager.shared.firestoreDB.collection("messages")
                .document(fromUserID)
                .collection(toUserID)
                .document()
            
            let messageData = ["fromUserID": fromUserID, "toUserID": toUserID, "text": self.chatText,"timestamp": Timestamp()] as [String : Any]
            
            document.setData(messageData) { error in
                if let error = error {
                    print("Failed to save message into Firestore: \(error)")
                    return
                }
                
                print("Successfully saved current user sending message")
                self.chatText = ""
            }
            
            let recipientMessageDocument = FirebaseManager.shared.firestoreDB.collection("messages")
                .document(toUserID)
                .collection(fromUserID)
                .document()
            
            recipientMessageDocument.setData(messageData) { error in
                if let error = error {
                    print("Failed to save message into Firestore: \(error)")
                    return
                }
                
                print("Recipient saved message as well")
            }
        }
    }
}

