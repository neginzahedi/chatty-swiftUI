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
                        //let data = change.document.data()
                        //let docID = change.document.documentID
                        
                        do {
                            if let message = try change.document.data(as: ChatMessage?.self) {
                                self.chatMessages.append(message)
                            }
                        } catch {
                            print("this is error: \(error)")
                        }
                    }
                })
            }
        // scroll page to bottom
        
    }
    
    // save new message to database "messages"
    func sendMessage(contactUID: String, text: String) {
        
        // fromID: current user uid
        guard let fromUserID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        // toID: contact user uid
        guard let toUserID = self.contact?.uid else {return}
        // message
        let message = [const.collection_messages_fromUserID: fromUserID, const.collection_messages_toUserID: toUserID, const.collection_messages_text: text,"timestamp": Timestamp()] as [String : Any]
        
        
        // 1. add the message to "messages" collection (fromUserID to toUserID)
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(fromUserID)
            .collection(toUserID)
            .document().setData(message) { error in
                if let error = error {
                    print("Failed: save new message to messages collection (fromUserID-toUserID): \(error.localizedDescription).")
                    return
                }
                print("Success: save new message to messages collection (fromUserID-toUserID).")
            }
        
        // 2. add the message to "messages" collection (toUserID to FromUserID)
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(toUserID)
            .collection(fromUserID)
            .document().setData(message) { error in
                if let error = error {
                    print("Failed: save new message to messages collection (toUserID to FromUserID): \(error.localizedDescription).")
                    return
                }
                print("Success: save new message to messages collection (toUserID to FromUserID).")
            }
        
        //   3. add recent message to "recentMessages" collection
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(fromUserID)
            .collection(const.collection_messages_recent_messages)
            .document(toUserID)
            .setData(message) { (error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                print("Recent message for current user saved")
            }
        
        // 4
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(toUserID)
            .collection(const.collection_messages_recent_messages)
            .document(fromUserID)
            .setData(message) { (error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                print("Recent message for recipient saved")
            }
        
        DispatchQueue.main.async {
            self.count += 1
        }
    }
}

