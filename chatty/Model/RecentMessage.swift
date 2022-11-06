//
//  RecentMessage.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-31.
//

import Foundation
import Firebase

// dictionary
struct RecentMessage: Identifiable {
    var id: String { docId }
    
    let docId: String
    let fromId: String
    let toId: String
    let timestamp: Timestamp
    let text: String
    
    init(docId: String, dictionary: [String: Any]) {
        self.docId = docId
        self.fromId = dictionary["fromUserID"] as? String ?? ""
        self.toId = dictionary["toUserID"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.timestamp = dictionary["timestamp"]
        as? Firebase.Timestamp ?? Firebase.Timestamp()
    }
}
