//
//  SettingsView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// SettingsView():

import SwiftUI
import SDWebImageSwiftUI

struct SettingsView: View {
    
    // view model to fetch user info
    @ObservedObject var vm = MainViewModel()
    
    // Boolean states to display sign-out actionSheet if true
    @State private var isSignOutClicked = false
    
    // To change current view
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView{
            List {
                // Section User Profile
                Section {
                    NavigationLink(destination: EditProfileView()){
                        HStack(spacing: 20){
                            if vm.currentUser?.profileImageUrl == "" {
                                Image("profile")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60,alignment: .leading)
                                    .cornerRadius(30)
                            } else {
                                WebImage(url: URL(string: vm.currentUser?.profileImageUrl ?? "profile"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60,alignment: .leading)
                                    .cornerRadius(30)
                            }
                            VStack(spacing:5){
                                // Username
                                Text(vm.currentUser?.username ?? "username")
                                // Status
                                Text("available")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            } // VStack
                        }.padding() // HStack
                    }
                } // Section User Profile
                // OTHER OPTIONS
                
                Section {
                    // TELL A FRIEND
                    Button {
                        shareLink()
                    } label: {
                        HStack(spacing: 20){
                            Image(systemName: "heart.fill")
                            Text("Tell a Friend")
                        }.foregroundColor(.primary)
                    }.padding()
                    
                    // ABOUT ME: LinkedIn account
                    Link(destination: URL(string: "https://www.linkedin.com/in/negin-zahedi")!){
                        HStack(spacing: 20){
                            Image(systemName: "info")
                            Text("About Me")
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                }
                
                // Sign out
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
        
        // actionSheet: confirm sign out
        .actionSheet(isPresented: $isSignOutClicked) {
            .init(title: Text("Sign Out"), message: Text("Do you want to sign out?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    self.signOutUser()
                }),
                .cancel()
            ])
        }
    }
    
    // TODO: ios 16 has ShareLink functionality but the app is ios 15
    func shareLink(){
        let url = URL(string: "https://github.com/neginzahedi/chatty-swiftUI")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    // Sign-out current user and navigate to WelcomeView()
    func signOutUser(){
        do {
            try FirebaseManager.shared.auth.signOut()
            print("Current user successfully signed out.")
            withAnimation {
                self.viewRouter.currentView = .pageWelcomeView
            }
        } catch let error {
            // handle error here
            print("Error when user try to sign-out: \(error.localizedDescription)")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
