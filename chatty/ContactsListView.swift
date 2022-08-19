//
//  ContactsListView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-18.
//
// ContactsListView: displays contact list, to add new contact, remove existing contact, and search

import SwiftUI

struct ContactsListView: View {
    @State private var contactName: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("search by email address or name", text:$contactName)
                        .textFieldStyle(.roundedBorder)
                    // TODO: search contact
                    Button {
                        print("search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                }.padding()
                // TODO: Display current user contact list
                List{
                    ForEach(0 ..< 5, id:\.self){ num in
                        HStack() {
                            // person's image
                            Image("mad")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .padding()
                            
                            VStack(alignment: .leading){
                                // contact name
                                Text("name")
                                    .font(.system(size: 16,weight: .bold))
                            }
                        }.foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // TODO: add new contact to list
                    Button {
                        print("add new contact")
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
