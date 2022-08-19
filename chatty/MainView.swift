//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// MainView is a TabView() to easily switch between ChatTableView(), SettingView() and ContactsView()
//
//TODO:

import SwiftUI
import Firebase


class MainModel: ObservableObject{
    @Published var errorMessagr = ""
    @Published var currentUser: CurrentUser?
    
    init(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user{
                self.currentUser =  CurrentUser(uid: user.uid , emailAddress: user.email! , profileImageUrl: "")
                errorMessagr = "we have a user"
            }
        } else {
            errorMessagr = "no current user"
        }
    }
}

struct MainView: View {
    
    @ObservedObject private var vm = MainModel()
    @State private var selectedTab = "Chats"
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContactsListView()
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }.tag("Contacts")
            ChatTableView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }.tag("Chats")
            SettingView(currentUser: vm.currentUser!)
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
