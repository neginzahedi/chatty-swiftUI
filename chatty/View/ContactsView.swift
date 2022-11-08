//
//  ContactsView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-18.
//
// ContactsView: displays contacts, add new contact,

import SwiftUI
import SDWebImageSwiftUI

struct ContactsView: View {
    @State private var contactUsername: String = ""
    @ObservedObject var vm = ContactsViewModel()
    
    init(){
        vm.fetchUserContacts()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("search username", text:$contactUsername)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        // TODO: search contact
                        print("search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                }.padding()
                if vm.contacts.isEmpty{
                    Empty()
                } else {
                    // TODO: alphabet order
                    List{
                        ForEach(vm.contacts, id: \.self){ contact in
                            NavigationLink {
                                ContactView(contactUID: contact.uid)
                            } label: {
                                HStack() {
                                    // contact image
                                    if contact.profileImageURL == "" {
                                        Image("profile")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60,alignment: .leading)
                                            .cornerRadius(30)
                                            .padding()
                                    } else {
                                        WebImage(url: URL(string: contact.profileImageURL ))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60,alignment: .leading)
                                            .cornerRadius(30)
                                            .padding()
                                    }
                                    // contact username
                                    VStack(alignment: .leading){
                                        Text(contact.username)
                                            .font(.system(size: 16,weight: .bold))
                                    }
                                }.foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contacts").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Trailing
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        // view to add new contact
                        AddContactView()
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct Empty: View {
    var body: some View{
        Spacer()
        Text("Find your chatty friends!")
            .foregroundColor(.secondary)
        Spacer()
        Spacer()
    }
}
struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
