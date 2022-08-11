//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//

import SwiftUI
import CoreMedia


struct ChatTableView: View {
    
    @State var showSettingOptions = false
    
    var body: some View {
        NavigationView{
            
            VStack{
                sendersList
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Image(systemName: "square.and.pencil"))
        }
        
        
    }
    
    
    // ScrollView: Senders List
    private var sendersList: some View{
        ScrollView{
            ForEach(0 ..< 10, id:\.self){ num in
                VStack{
                    // Sender
                    senderMessageRow
                    Divider()
                        .padding(.vertical,8)
                }.padding(.horizontal)
            }.padding(.bottom,50)
        }
    }
    
    // HStack: Sender
    private var senderMessageRow: some View{
        NavigationLink {
            ChatView()
        } label: {
            HStack(spacing: 16) {
                Image("kiss")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading){
                    Text("Username")
                        .font(.system(size: 16,weight: .bold))
                    Text("Text messages")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.lightGray))
                }
                
                Spacer()
                
                Text("2m")
                    .font(.system(size: 14,weight: .semibold))
            }.foregroundColor(.primary)
        }
        
        
    }
    
}

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
        
    }
}
