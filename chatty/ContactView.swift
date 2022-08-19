//
//  ContactView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-19.
// TODO: ContactView()

import SwiftUI

struct ContactView: View {
    
    @State private var contactName: String = "Ida"
    var body: some View {
        VStack{
            Image("dead")
                .resizable()
                .scaledToFit()
                .padding()
            VStack{
                Text("Contact Name")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("email address")
            }
            .padding()
            
            List(){
                NavigationLink {
                    ChatView()
                } label: {
                        Image(systemName: "message.fill")
                        Text("Send Message")
                }
                HStack{
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Media, images, video")
                }
                Text("Delete " + contactName)
                    .foregroundColor(.red)
                Text("Block " + contactName)
                    .foregroundColor(.red)
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
