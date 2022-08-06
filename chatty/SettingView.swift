//
//  SettingView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        
        NavigationView{
            List {
                
                //user profile
                Section {
                    NavigationLink(destination: EditProfileView()){
                        HStack(spacing: 20){
                            Image("question-face")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60,alignment: .leading)
                                .padding()
                                .overlay(
                                    Circle().stroke(lineWidth: 3)
                                )
                            VStack(spacing:5){
                                Text("Username")
                                Text("available")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            }
                            
                        }.padding()
                    }
                }
                
                // Other options
                Section {
                    NavigationLink(destination:EmptyView()){
                        HStack(spacing: 20){
                            Image(systemName: "heart.fill")
                            Text("Tell a Friend")
                        }.padding()
                    }
                    
                    NavigationLink(destination: EmptyView()){
                        HStack(spacing: 20){
                            Image(systemName: "info")
                            Text("About Me")
                        }.padding()
                    }
                    
                    
                }
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Setting")
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
