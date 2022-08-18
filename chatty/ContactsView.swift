//
//  ContactsView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-18.
//

import SwiftUI

struct ContactsView: View {
    @State private var name: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                HStack{
                    TextField("search by email address or name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        print("search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                }.padding()
                
                List{
                    ForEach(0 ..< 5, id:\.self){ num in
                        HStack() {
                            // person's image
                            Image("mad")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .padding()
                            
                            VStack(alignment: .leading){
                                // contact name
                                Text("name")
                                    .font(.system(size: 16,weight: .bold))
                            }
                        }.foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("add new contact")
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.primary)
                    }
                    
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
