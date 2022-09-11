//
//  ChatView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//
// ChatView() contains all chat messages between user and reciever.


import SwiftUI
import Firebase

struct ChatView: View {
    let contactUsername: String
    init(contactUsername: String){
        self.contactUsername = contactUsername
        self.vm = .init(chatUser: contactUsername)
    }
    @ObservedObject private var vm : ChatViewModel
    
    var body: some View {
        VStack{
            ScrollView{
                // TODO: background color need to be changed to gray for reciever and blue for sender.
                // TODO: retrieve messages from firestore
                ForEach(vm.chatMessages){ message in
                    HStack{
                        Spacer()
                        HStack{
                            Text(message.text)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(30)
                    }
                    .padding(.horizontal)
                    .padding(.top,8)
                }
            }.background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    HStack{
                        // TODO: picking photo
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.secondary)
                        
                        TextField("type here...", text: $vm.chatText)
                            .textFieldStyle(.roundedBorder)
                        
                        Button(){
                            sendMessage()
                        }label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.secondary)
                        }
                    }.padding()
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.secondary)
                    Text(contactUsername)
                }
            }
        }
    }
    // TODO: send message
    private func sendMessage(){
        vm.handleSend()
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contactUsername: "")
    }
}
