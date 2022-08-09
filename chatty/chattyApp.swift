//
//  chattyApp.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI
import Firebase

@main
struct chattyApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
