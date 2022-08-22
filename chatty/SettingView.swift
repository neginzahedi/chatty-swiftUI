//
//  SettingView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// SettingView has two section. One is for user profile setting, other options are for sharing link and about me. (NOT DECIDED YET)
//
// NOTES: Design is completed.

import SwiftUI
import SDWebImageSwiftUI

struct SettingView: View {
    
    @ObservedObject private var vm = MainModel()
    
    let currentUser: CurrentUser
    @State private var isSignOutClicked = false
    var body: some View {
        NavigationView{
            List {
                // USER PROFILE
                Section {
                    NavigationLink(destination: EditProfileView(currentUser: currentUser)){
                        HStack(spacing: 20){
                            WebImage(url: URL(string: currentUser.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60,alignment: .leading)
                                .cornerRadius(30)
                            
                            VStack(spacing:5){
                                Text(currentUser.email)
                                Text("available")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            }
                        }.padding()
                    }
                }
                // OTHER OPTIONS
                Section {
                    // TELL A FRIEND
                    // TODO: share a link
                    Button {
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
                // TODO: Sign out user
                Section {
                    Button {
                        isSignOutClicked.toggle()
                    } label: {
                        HStack(spacing: 20){
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign out")
                        }.foregroundColor(.primary)
                    }
                }
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Settings")
        }
        .actionSheet(isPresented: $isSignOutClicked) {
            .init(title: Text("Sign Out"), message: Text("Do you want to sign out?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    vm.signOutUser()
                }),
                .cancel()
            ])
        }
        .fullScreenCover(isPresented: $vm.isUserLoggedOut, onDismiss: nil) {
            WelcomeView()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(currentUser: CurrentUser(uid: "uid", username: "username", email: "email", profileImageUrl: "profileImageURL", status: "status"))
    }
}
