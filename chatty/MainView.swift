//
//  MainView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//

import SwiftUI

struct MainView: View {
    
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection){
            
            ChatTableView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill" )
                }.tag(2)
            
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear" )
                }.tag(1)
            
        }.navigationTitle(selection == 1 ? "Settings" : "Chats")
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
