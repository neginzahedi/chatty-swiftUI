//
//  ContactView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-19.
// TODO: ContactView()

import SwiftUI

struct ContactView: View {
    
    @State var contactUsername: String
    
    var body: some View {
        VStack{
            Image("dead")
                .resizable()
                .scaledToFit()
                .padding()
            VStack{
                Text(contactUsername)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("email address")
            }
            .padding()
            
            List(){
                NavigationLink {
                    ChatView(contactUsername: contactUsername)
                } label: {
                        Image(systemName: "message.fill")
                        Text("Send Message")
                }
                HStack{
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Media, images, video")
                }
                Text("Delete " + contactUsername)
                    .foregroundColor(.red)
                Text("Block " + contactUsername)
                    .foregroundColor(.red)
            }
        }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(contactUsername: "contactUsername")
    }
}
