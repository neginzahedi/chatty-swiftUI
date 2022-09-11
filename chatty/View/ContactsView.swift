//
//  ContactsView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-18.
//
// ContactsView: displays contacts, add new contact,

import SwiftUI

struct ContactsView: View {
    @State private var contactEmail: String = ""
    @ObservedObject var vm = MainViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("search username", text:$contactEmail)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        // TODO: search contact
                        print("search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                }.padding()
                if vm.userContacts != [""]{
                    List{
                        ForEach(vm.userContacts, id: \.self){ contact in
                            NavigationLink {
                                ContactView(contactUsername: contact)
                            } label: {
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
                                        Text(contact)
                                            .font(.system(size: 16,weight: .bold))
                                    }
                                }.foregroundColor(.primary)
                            }
                        }
                    }
                    
                } else {
                    Empty()
                }
            }
            .navigationTitle("Contacts")
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
