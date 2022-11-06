//
//  ChatMessage.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-11-06.
//

import Foundation


struct ChatMessage: Identifiable{
    
    let const = Constant()

    let documentID: String
    var id: String {documentID}
    let fromID: String
    let toID: String
    let text: String
    
    init(documentID: String, data: [String: Any]){
        self.documentID = documentID
        self.fromID = data[const.collection_messages_fromUserID] as? String ?? ""
        self.toID = data [const.collection_messages_toUserID] as? String ?? ""
        self.text = data[const.collection_messages_text] as? String ?? ""
    }
}
