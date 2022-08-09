//
//  EditProfileView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var status: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        NavigationView{
            
            VStack{
              
                Image("main-img")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                List{
                    
                    Section{
                        HStack{
                            Text("Name")
                            Spacer()
                            Spacer()
                            TextField("Name", text: $name)
                        }
                        
                        HStack{
                            Text("Email address")
                            Spacer()
                            Spacer()
                            TextField("Email address", text: $email)
                        }
                        
                        HStack{
                            Text("Status")
                            Spacer()
                            Spacer()
                            TextField("Status", text: $status)
                        }
                    }
                    
                    Section{
                        NavigationLink {
                            ChangepasswordView()
                        } label: {
                            Text("Password")
                        }
                    }
                  
                }.listStyle(InsetGroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                    .navigationTitle("Edit Profile")
                
            }
        }

    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
