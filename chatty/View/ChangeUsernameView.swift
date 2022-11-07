//
//  ChangeUsernameView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-27.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    @State private var newUsername: String = ""
    
    @ObservedObject var vm = MainViewModel()
    
    @State var isUsernameExistAlert = false
    @State var isUsernameUpdated = false
    
    @State var alertMessage = ""
    
    let const = Constant()
    
    var body: some View {
        VStack{
            Image("dead")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Text("Your username is unique on chatty and your friends can find you by this username.")
                .foregroundColor(.gray)
                .padding()
            Spacer()
            List{
                HStack{
                    Text("Username")
                    TextField(vm.currentUser?.username ?? "username", text: $newUsername)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    // replace "whitespace" with _
                        .onChange(of: newUsername) { char in
                            newUsername = char.replacingOccurrences(of: " ", with: "_")
                        }
                        .padding(10)
                }
                
            }
        }
        // alert: username is not available
        .alert(alertMessage, isPresented: $isUsernameExistAlert) {
            Button("Ok", role: .cancel) { }
        }
        // alert: username updated
        .alert(alertMessage, isPresented: $isUsernameUpdated) {
            Button("Ok", role: .cancel) { }
        }
        .navigationBarTitle(Text("Change Username"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            changeUsername(newUsername: self.newUsername.lowercased())
        }, label: {
            Text("Save")
        }))
    }
    
    
    private func changeUsername(newUsername: String){
        print("save new username clicked.")
        
        let uid = vm.currentUser!.uid
        let username = vm.currentUser!.username
        
        // 1. check if new username is unique
        FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(newUsername).getDocument { documentSnapshot, error in
            if let doc = documentSnapshot{
                if doc.exists{
                    print("The username is not available.")
                    // display alert
                    self.alertMessage = "The username is already taken. Choose diffrent username."
                    self.isUsernameExistAlert = true
                } else{
                    print("username is available.")
                    // 1. add new username and uid to username_id DB
                    FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(newUsername).setData([
                        "uid": uid,
                        "username": newUsername
                    ]){ error in
                        if let e = error{
                            print("Faild to save user to users collection: \(e)")
                            return
                        }
                    }
                    // delete old one
                    FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(username).delete()
                    // 2. update username in users
                    FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).updateData(["username" : newUsername])
                    // 3. alert username updated
                    self.alertMessage = "Username updated!"
                    self.isUsernameUpdated = true
                }
            }
            
        }
    }
}



struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView()
    }
}
