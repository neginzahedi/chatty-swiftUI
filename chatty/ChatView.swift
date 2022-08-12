//
//  ChatView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//
// ChatView() contains all chat messages between user and reciever.

// TODO: Design is not done
// background color need to be changed to gray for reciever and blue for sender.
// picking photo is not working
// send message is not working
// displaying messages from firebase is not working

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack{
            ChatBodyScrollView()
            ChatBottomView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.secondary)
                    Text("Reciever's Name")
                }
            }
        }
    }
}

// contains all messages which retrieves from firestore
struct ChatBodyScrollView: View{
    var body: some View {
        ScrollView{
            // TODO: retrieve messages from firestore
            ForEach(0..<10){ num in
                HStack{
                    
                    Spacer()
                    
                    HStack{
                        Text("This is a message")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                }
                .padding(.horizontal)
                .padding(.top,8)
            }
        }
    }
}

// ChatBottomView contains picking photos, type message and send message.
struct ChatBottomView: View{
    
    @State private var message: String = ""
    
    var body: some View{
        HStack{
            // TODO: picking photo
            Image(systemName: "photo.on.rectangle.angled")
            
            TextField("Hey type here",text:$message )
                .cornerRadius(10)
            
            Button(){
                sendMessage()
            }label: {
                Image(systemName: "paperplane.fill")
            }
            
        }.padding()
    }
    
    //TODO: send message to firestore
    private func sendMessage(){
        
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
