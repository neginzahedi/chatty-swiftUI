//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//

import SwiftUI

struct ChatTableView: View {
    var body: some View {
        NavigationView{
            VStack{
                // user navbar
                HStack(spacing: 16){
                    // user image
                    Image(systemName: "person.fill")
                        .font(.system(size: 34, weight: .heavy))
                    
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
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Image(systemName: "gear")
                }.padding()
                
                // user messages
                ScrollView{
                    ForEach(0 ..< 10, id:\.self){ num in
                        VStack{
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.black,lineWidth: 1))
                                
                                VStack(alignment: .leading){
                                    Text("username")
                                        .font(.system(size: 14,weight: .bold))
                                    Text("messages")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("2m")
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            Divider()
                                .padding(.vertical,8)
                        }.padding(.horizontal)
                    }
                    
                }
                
            }
            .overlay(
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
                    shadow(radius: 15)
                },alignment: .bottom)
            
            // hide nav bar
            .navigationBarHidden(true)
            
        }
    }
}

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
    }
}
