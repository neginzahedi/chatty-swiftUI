//
//  userModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-08.
//

import Foundation

struct CurrentUser {
    let uid: String
    let username: String
    let email: String
    let profileImageUrl:String
    let status: String
    let contacts_uid: [Any]
}
