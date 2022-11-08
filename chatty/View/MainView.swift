//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// MainView: Is a TabView with three options: Contacts, Chat and Settings
//

import SwiftUI

struct MainView: View {
    
    // default view is ChatTableView()
    @State private var selectedTab = "Chats"
    
    // ViewModel to fetch current user
    @ObservedObject var vm = MainViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContactsView()
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }.tag("Contacts")
            ChatTableView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }.tag("Chats")
            SettingsView(vm: self.vm)
                .tabItem {
                    Label("Settings", systemImage: "gear" )
                }.tag("Settings")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
