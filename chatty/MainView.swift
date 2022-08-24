//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// MainView is a TabView() to easily switch between ChatTableView(), SettingView() and ContactsView()


import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = "Chats"
    
    var body: some View {
        TabView(selection: $selectedTab){
            FriendsListView()
                .tabItem {
                    Label("Friends", systemImage: "person.2.fill")
                }.tag("Friends")
            ChatTableView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }.tag("Chats")
            SettingView()
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
