//
//  AddContactView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-24.
//
// AddContactView: User can find other users by searching their usernames and add them to contact list.

import SwiftUI

struct AddContactView: View {
    
    @State private var username: String = ""
    
    // view model has method to fetch contact
    @ObservedObject var vm = AddContactViewModel()
    
    var body: some View {
        VStack{
            Image("sign-in")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Add your chatty friend")
                .font(.title)
                .fontWeight(.bold)
            Text("You will need your firend's username or email address to add.")
                .font(.caption)
                .foregroundColor(.secondary)
            
            
            TextField("username", text: $username)
                .padding()
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
            
            Button {
                vm.findContact(contactUsername: username)
            } label: {
                Text("Find")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
        }.padding()
            .navigationTitle("Add Friends")
            .navigationBarTitleDisplayMode(.inline)
        
        
        // alerts
        // user found
            .alert("New ContactUser", isPresented: $vm.isContactFound, actions: {
                Button("Add", action: addNewContact)
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Do you want to add \(username.lowercased()) as your new contact?")
            })
        // user not found
            .alert("Error", isPresented: $vm.isContactNotFound, actions: {
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("The username does not exist.")
            })
        // new contact added
            .alert("New contact added!", isPresented: $vm.isContactAddedAlert) {
                Button("Ok", role: .cancel) {}
            }
    }
    
    func addNewContact(){
        vm.addNewContact(contactUsername: username)
    }
    
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
