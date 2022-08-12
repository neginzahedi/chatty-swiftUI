//
//  ChatTableView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-07-31.
//
// ChatTablesView() contains list of messages has been sent to the user based on date.
import SwiftUI
import CoreMedia


struct ChatTableView: View {
    var body: some View {
        NavigationView{
            ScrollListView()
                .navigationTitle("Chats")
                .navigationBarItems(leading:Text("Edit"), trailing: Image(systemName: "square.and.pencil"))
        }
    }
    
    
    struct ScrollListView: View{
        var body: some View{
            ScrollView{
                ForEach(0 ..< 10, id:\.self){ num in
                    VStack{
                        MessageRow()
                        Divider()
                            .padding(.vertical,8)
                    }.padding(.horizontal)
                }.padding(.bottom,50)
            }
        }
    }
    
    // when user clicks on each MessageRow, it will navigate user to ChatView()
    // TODO: NOT WORKING
    struct MessageRow: View {
        var body: some View{
            NavigationLink {
                ChatView()
            } label: {
                HStack(spacing: 16) {
                    // person's image
                    Image("kiss")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .padding()
                    
                    VStack(alignment: .leading){
                        // username
                        Text("Username")
                            .font(.system(size: 16,weight: .bold))
                        //last message in chat
                        Text("Text messages")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    
                    Spacer()
                    
                    // last message date
                    Text("date")
                        .font(.system(size: 14,weight: .semibold))
                }.foregroundColor(.primary)
            }
        }
    }
}

struct ChatTableView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTableView()
        
    }
}
