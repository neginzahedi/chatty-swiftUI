//
//  AddContactView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-24.
//

import SwiftUI
import Firebase

struct AddContactView: View {
    
    @State private var username: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State private var isFindContactAlert = false
    @State private var isFindContactFaildAlert = false
    
    var body: some View {
        VStack{
            Image("kiss")
                .resizable()
                .frame(width: 150, height: 150)
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
                findContact()
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
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
        
        
        // alerts
            .alert("New Contact", isPresented: $isFindContactAlert, actions: {
                Button("Add", action: addNewContact)
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Do you want to add \(username.lowercased()) as your new contact?")
            })
            .alert("Error", isPresented: $isFindContactFaildAlert, actions: {
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("The username does not exist.")
            })
        
    }
    
    func findContact(){
        let docRef = FirebaseManager.shared.firestoreDB.collection("usernames").document(username.lowercased())
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                isFindContactAlert.toggle()
            } else {
                print("Document does not exist")
                isFindContactFaildAlert.toggle()
            }
        }
    }
    
    func addNewContact(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        FirebaseManager.shared.firestoreDB.collection("registeredUsers").document(uid).updateData([
            "contacts" : FieldValue.arrayUnion([username.lowercased()])
        ]) { error in
            if let e = error {
                print("error add contact: \(e)")
                return
            } else{
                print("contact added.")
            }
        }
        
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
