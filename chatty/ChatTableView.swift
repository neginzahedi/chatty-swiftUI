//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        Text("")
    }
}

struct ChatTableView: View {
    
    @State var showSettingOptions = false
    
    var body: some View {
        NavigationView{
            VStack{
                // Nav bar: User Profile
//                UserProfileView()
                userProfile
                // ScrollView: Sender Message List
                sendersList
            }
            .overlay(newMessageButton,alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
    
    // HStack: User Profile
    private var userProfile: some View{
        HStack(spacing: 16){
            // user image
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.black,lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4){
                // user username
                Text("username")
                    .font(.system(size: 24,weight: .bold))
                
                HStack{
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    // user status
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            
            NavigationLink(destination: SettingView()){
                Image(systemName: "gear")
                    .font(.system(size: 24,weight: .bold))
                    .foregroundColor(Color(.label))
                    
            }
            
        }.padding()
           
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
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .font(.system(size: 32))
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.black,lineWidth: 1))
            
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
        }
    }
    
    // Button: Create New Message
    private var newMessageButton: some View{
        Button{
            
        }label: {
            HStack{
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(35)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
    }
}

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
    }
}
