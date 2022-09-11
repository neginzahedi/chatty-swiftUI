//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// MainView: The view has a TabView() to easily switch between ChatTableView(), SettingsView() and ContactsView()

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = "Chats"
    @ObservedObject var vm = MainViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContactsView(vm: self.vm)
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }.tag("Contacts")
            ChatTableView(vm: self.vm)
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }.tag("Chats")
            SettingsView(vm: self.vm)
                .tabItem {
                    Label("Settings", systemImage: "gear" )
                }.tag("Settings")
        }.onAppear(){
            self.vm.fetchCurrentUser()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
