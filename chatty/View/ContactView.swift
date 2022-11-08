//
//  ContactView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-19.
// TODO: ContactView()

import SwiftUI
import SDWebImageSwiftUI

struct ContactView: View {
    
    @State var contactUID: String?
    @ObservedObject var vm = ContactViewModel()
    
    var body: some View {
        VStack{
            // image
            if vm.contact?.profileImageURL == "" {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200,alignment: .leading)
                    .cornerRadius(50)
            } else {
                WebImage(url: URL(string: vm.contact?.profileImageURL ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200,alignment: .leading)
                    .cornerRadius(100)
            }
            VStack{
                // username
                Text(vm.contact?.username ?? "username")
                    .font(.title2)
                    .fontWeight(.bold)
                // status
                Text(vm.contact?.status ?? "status")
            }
            .padding()
            
            List(){
                // send message
                NavigationLink {
                    ChatView(user: vm.contact)
                } label: {
                    Image(systemName: "message.fill")
                    Text("Send Message")
                }
                HStack{
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Media, images, video")
                }
                // TODO: delete contact
                Text("Delete " + (vm.contact?.username ?? "username"))
                    .foregroundColor(.red)
                // TODO: block contact
                Text("Block " + (vm.contact?.username ?? "username"))
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            vm.getContact(uid: contactUID ?? "uid")
        }
    }
}
struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
