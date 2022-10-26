//
//  chattyApp.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-28.
//

import SwiftUI

@main
struct chattyApp: App {
    
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}
