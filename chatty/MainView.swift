//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// MainView is a TabView() to easily switch between ChatTableView() and SettingView()
//
//TODO:

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView(){
            ChatTableView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }
            
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear" )
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
