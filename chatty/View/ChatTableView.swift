//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//
// ChatTablesView: contains list of messages has been sent to the user based on date.

import SwiftUI
import CoreMedia
import SDWebImageSwiftUI
import Firebase
import Foundation

struct ChatTableView: View {
    
    // view model to fetch recent message
    @ObservedObject var vm = ChatTableViewModel()
    
    // to display new message sheet
    @State private var isNewMessageSheetDisplay = false
    // for new message
    @State var isChatViewDisplay = false
    
    @State var contact: ContactUser?
    var currentUID = FirebaseManager.shared.auth.currentUser?.uid
    
    var body: some View {
        NavigationView{
            VStack{
                if vm.recentMessages.isEmpty{
                    EmptyChatTable()
                }else {
                    ScrollView{
                        ForEach(vm.recentMessages){ recentMessage in
                            if recentMessage.fromId == currentUID {
                                ChatRow(contactUID: recentMessage.toId,message: recentMessage)
                            } else {
                                ChatRow(contactUID: recentMessage.fromId,message: recentMessage)
                            }
                        }.padding(.bottom,50)
                    }
                }
                
                // to display chatView(contact) when contact is selected from NewMessageSheetView()
                NavigationLink("",isActive: $isChatViewDisplay) {
                    ChatView(user: contact)
                }
                
            }
            .navigationTitle("Chats").navigationBarTitleDisplayMode(.inline)
            // TODO: Edit Button
            // New Message Button
            .navigationBarItems(leading:Text("Edit"), trailing:Button(action: {
                isNewMessageSheetDisplay.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
            } ))
            // To display NewMessageSheetView()
            .sheet(isPresented: $isNewMessageSheetDisplay) {
                NewMessageSheetView(selectedContact: { contact in
                    self.contact = contact
                    self.isChatViewDisplay.toggle()
                })
            }
            
        }
    }
}

// when chat table is empty
struct EmptyChatTable: View{
    var body: some View{
        VStack (alignment: .center, spacing: 20){
            Image("signup-view-img")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Start chat with your favoutite people!")
                .foregroundColor(.secondary)
        }.padding()
    }
}


struct ChatRow: View {
    
    // Firebase Constants
    let const = Constant()
    
    // contact's uid
    var contactUID: String
    
    // recent message in chat
    var message: RecentMessage
    
    @State var user: ContactUser?
    
    var currentTime = Timestamp()

    var body: some View{
        VStack{
            NavigationLink {
                ChatView(user: user)
            } label: {
                HStack(spacing: 16) {
                    // person's image
                    if user?.profileImageURL == ""{
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                    } else {
                        WebImage(url: URL(string: user?.profileImageURL ?? "profile"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                    }
                    
                    VStack(alignment: .leading){
                        // username
                        Text(user?.username ?? "username")
                            .font(.system(size: 16,weight: .bold))
                        //last message in chat
                        Text(message.text)
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    Spacer()
                    // last message date
                    Text(message.timestamp.timeDifference)
                        .font(.system(size: 14,weight: .semibold))
                }.foregroundColor(.primary)
            }
            Divider()
                .padding(.vertical,8)
        }.padding(.horizontal)
            .onAppear(){
                fetchUser(uid:contactUID)
            }
    }
    
    
    func fetchUser(uid:String){
        print("user fetched")
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).getDocument { documentSnapshot, error in
            if let e = error{
                print("Error: \(e.localizedDescription)")
                return
            }
            guard let doc = documentSnapshot else {
                print("Error: there is no doc.")
                return
            }
            guard let data = doc.data() else {
                print("Error: there is no data.")
                return
            }
            
            // set chat user info
            let username = data[const.collection_users_username] as? String ?? ""
            let uid = data[const.collection_users_uid] as? String ?? ""
            let profileImageURl = data[const.collection_users_profileImageURL] as? String ?? ""
            let email = data[const.collection_users_email] as? String ?? ""
            let status = data[const.collection_users_status] as? String ?? ""
            self.user = ContactUser(uid: uid, username: username, email: email, profileImageURL: profileImageURl, status: status)
        }
    }
}

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
    }
}
