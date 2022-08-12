//
//  SettingView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// SettingView has two section. One is for user profile setting, other options are for sharing link and about me. (NOT DECIDED YET)
//
// NOTES: Desihn is completed.

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView{
            List {
                // SECTION USER PROFILE
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
                
                // SECTION OTHER OPTIONS
                Section {
                    // TELL A FRIEND
                    // share a link
                    Button {
                        let url = URL(string: "https://neginzahedi.com")
                        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
                    } label: {
                        HStack(spacing: 20){
                            Image(systemName: "heart.fill")
                            Text("Tell a Friend")
                        }.foregroundColor(.primary)
                    }.padding()
                    
                    // TODO: ABOUT ME
                    NavigationLink(destination: EmptyView()){
                        HStack(spacing: 20){
                            Image(systemName: "info")
                            Text("About Me")
                        }.padding()
                    }
                    
                }
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Settings")
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
