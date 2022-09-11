//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//
// ChatTablesView: contains list of messages has been sent to the user based on date.
//

import SwiftUI
import CoreMedia

struct ChatTableView: View {
    // view model has method to fetch current user
    @ObservedObject var vm = MainViewModel()
    var body: some View {
        NavigationView{
            VStack{
                if vm.userContacts != [""] {
                    ScrollView{
                        // TODO: display chats
                        ForEach(vm.userContacts, id:\.self){ contact in
                            VStack{
                                NavigationLink {
                                    ChatView(contactUsername: contact)
                                } label: {
                                    HStack(spacing: 16) {
                                        // person's image
                                        Image("kiss")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .padding()
                                        
                                        VStack(alignment: .leading){
                                            // username
                                            Text(contact)
                                                .font(.system(size: 16,weight: .bold))
                                            //last message in chat
                                            Text("Text messages")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(.lightGray))
                                        }
                                        Spacer()
                                        // last message date
                                        Text("date")
                                            .font(.system(size: 14,weight: .semibold))
                                    }.foregroundColor(.primary)
                                }
                                Divider()
                                    .padding(.vertical,8)
                            }.padding(.horizontal)
                        }.padding(.bottom,50)
                    }                } else {
                        startChatView()
                    }
            }
            .navigationTitle("Chats")
            // TODO: Edit Button
            // TODO: New Message Button
            .navigationBarItems(leading:Text("Edit"), trailing: Image(systemName: "square.and.pencil"))
        }
    }
}

// when chat table is empty
struct startChatView: View{
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

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
    }
}
