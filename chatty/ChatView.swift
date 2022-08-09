//
//  ChatView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//

import SwiftUI

struct ChatView: View {
    
    struct chatMessage{
        let sender: String
        let date: Date
        let body: String
    }
    
    var body: some View {
        VStack{
            ChatTopView()
            ChatBody()
            ChatBottomView()
            
 
        }
        .navigationTitle("Reciever name")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct ChatTopView: View{
    var body: some View{
        HStack{
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
            HStack{
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.secondary)
                Text("Reciever name")
                    .font(.footnote)
            }
            Spacer()
           
        }.padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct ChatBody: View{
    var body: some View {
        ScrollView{
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
            
            HStack{Spacer()}
        }
        
    }
    
}

struct ChatBottomView: View{
    
    @State private var message: String = ""

    var body: some View{
        HStack{
            Image(systemName: "photo.on.rectangle.angled")
            TextField("Hey type here",text:$message )
                .cornerRadius(10)
            
            Button(){
                
            }label: {
                Image(systemName: "paperplane.fill")
            }
            
        }.padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
