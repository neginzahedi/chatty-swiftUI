//
//  ChatTableViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-05.
//

import Foundation

class ChatTableViewModel: ObservableObject {
    
    // firebase constants
    let const = Constant()

    @Published var chatContact = [ContactUser]()
    
    @Published var errorMessage = ""
    
    @Published var chatTableUser: ChatUser?
    
    
    // 1
    @Published var recentMessages = [RecentMessage]()
    @Published var chatUsers = [ChatUser]()
    
    init(){
        fetchChatTableUsers()
    }
    
    func fetchChatTableUsers(){
        fetchRecentMessages()
    }
    
    
    // 2
    func fetchRecentMessages() {
        // current user uid
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        //
        FirebaseManager.shared.firestoreDB
            .collection(const.collection_messages)
            .document(uid)
            .collection(const.collection_messages_recent_messages)
            .order(by:"timestamp")
            .addSnapshotListener { querySnapshot, error in
                
                if let err = error {
                    self.errorMessage = err.localizedDescription
                    return
                }
                querySnapshot?.documentChanges.forEach({ documentChange in
                    let data = documentChange.document.data()
                    let docId = documentChange.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { recentMessage in
                        return recentMessage.docId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    self.recentMessages.insert(.init(docId: docId, dictionary: data), at: 0)
                })
            }
    }
}
