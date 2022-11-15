//
//  ChatView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//
// ChatView() contains all chat messages between user and reciever.


import SwiftUI
import SDWebImageSwiftUI

struct ChatView: View {
    
    // contact uid
    @State var user: ContactUser?
    @State var text: String = ""
    
    // vm to fetch
    @ObservedObject var vm : ChatViewModel
    
    // disable send button when text field is empty
    var disabledSendButton: Bool {
        text.isEmpty
    }
    init(user: ContactUser?){
        self.user = user
        self.vm = ChatViewModel(contact: user)
    }
    
    var body: some View {
        VStack{
            ScrollView{
                ScrollViewReader { scrollViewProxy in
                    VStack{
                        ForEach(vm.chatMessages){ message in
                            MessageView(message: message)
                        }
                        HStack{Spacer()}
                            .id("Empty")
                    }
                    .onReceive(vm.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)){
                            scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                        }
                    }
                }
            }
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom) {
                HStack{
                    // TODO: picking photo
                    Button {
                    } label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.secondary)
                    }
                    
                    TextField("type here...", text: $text)
                        .textFieldStyle(.roundedBorder)
                    // Button: save new message to firestore
                    Button(){
                        vm.sendMessage(contactUID: user?.uid ?? "", text: self.text)
                        self.text = ""
                        print("button")
                    }label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.secondary)
                    }.disabled(disabledSendButton)
                }.padding()
                    .background(Color(.systemBackground).ignoresSafeArea())
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    if user?.profileImageURL == ""{
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    } else {
                        WebImage(url: URL(string: user?.profileImageURL ?? "profile"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    }
                    Text(user?.username ?? "no")
                }
            }
        }
    }
}

// currentUser/contactUser message
struct MessageView: View {
    let message: ChatMessage
    var body: some View{
        VStack{
            // Right-Side: Current signed-in user message
            if message.fromUserID == FirebaseManager.shared.auth.currentUser?.uid{
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
            }
            // Left-Side: Contact user message
            else {
                HStack{
                    HStack{
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top,8)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: ContactUser(uid: "", username: "", email: "", profileImageURL: "", status: ""))
    }
}
