//
//  ChatViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-09-01.
//

import Foundation
import Firebase

struct ChatMessage: Identifiable {
    var id: String {documentID}
    let fromID: String
    let toID: String
    let text : String
    let documentID: String
    
    init(documentID:String, data: [String: Any]){
        self.documentID = documentID
        self.fromID = data["fromID"] as? String ?? ""
        self.toID = data["toID"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}

class ChatViewModel: ObservableObject {
    
    // contact user
    let chatUser: String
    
    // body of message
    @Published var chatText = ""
    // array of type ChatMessage
    @Published var chatMessages = [ChatMessage]()
    
    init(chatUser: String){
        self.chatUser = chatUser
        fetchMessages()
    }
    
    func fetchMessages(){
        // from user is current user
        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        // find chat user ID
        FirebaseManager.shared.firestoreDB.collection("usernames").document(chatUser).addSnapshotListener { documentSnapshot, error in
            if let e = error {
                print(e)
                return
            }
            
            guard let data = documentSnapshot?.data()
            else {
                print("No data found for current user usernames collection")
                return
            }
            let toID =  data["uid"] as? String ?? ""
            // get data from db
            FirebaseManager.shared.firestoreDB.collection("messages")
                .document(fromID)
                .collection(toID)
                .order(by: "timestamp")
                .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("Faild to get messages \(e)")
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
        }
    }
    
    func handleSend() {
        // current signed in user is from user
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
