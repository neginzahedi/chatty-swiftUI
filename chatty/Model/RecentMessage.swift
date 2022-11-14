//
//  RecentMessage.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// dictionary
struct RecentMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    let fromUserID: String
    let text: String
    let timestamp: Date
    let toUserID: String
    
    var timePassed: String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
