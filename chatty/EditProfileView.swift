//
//  EditProfileView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// EditProfileView contains user's saved name, email address, status and Password which can be changed as well.
//
// TODO: save changes user make
// replace placeholders with current info

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var status: String = ""
    
    var body: some View {
        VStack{
            Image("main-img")
                .resizable()
                .scaledToFit()
                .padding()
            
            List{
                // TODO: Current User info Section
                Section{
                    HStack{
                        Text("Name")
                        Spacer()
                        Spacer()
                        TextField("Name", text: $name)
                    }
                    HStack{
                        Text("Email address")
                        Spacer()
                        Spacer()
                        TextField("Email address", text: $email)
                    }
                    HStack{
                        Text("Status")
                        Spacer()
                        Spacer()
                        TextField("Status", text: $status)
                    }
                }
                
                // Password Section: navigates to ChangepasswordView
                Section{
                    NavigationLink {
                        ChangepasswordView()
                    } label: {
                        Text("Password")
                    }
                }
                
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Edit Profile")
                .navigationBarItems(trailing: Text("Save"))
            
        }
    }
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
