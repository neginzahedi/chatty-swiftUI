//
//  ChatMessage.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-11-06.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatMessage: Codable, Identifiable{
    
    //let documentID: String
    @DocumentID var id: String?
    let fromUserID: String
    let toUserID: String
    let text: String
}
